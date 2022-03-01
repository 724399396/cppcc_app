import 'package:cppcc_app/bloc/timer_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _formChanged = false;
  String? _phone;
  String? _verifyCode;
  String? _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var phoneValidatorRegex = RegExp(r"^[0-9]{11}$");
    const itemSpace = SizedBox(height: 20);

    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop()),
        title: Text('忘记密码',
            style: themeData.primaryTextTheme.headline6
                ?.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          onChanged: _onFormChange,
          onWillPop: _onWillPop,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  key: const ValueKey('phone'),
                  onSaved: (String? val) => _phone = val,
                  onChanged: (val) {
                    setState(() {
                      _phone = val;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: '请输入手机号码',
                      hintStyle: themeData.textTheme.subtitle1
                          ?.copyWith(color: Colors.grey)),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? val) {
                    if (val?.isEmpty ?? true) return '手机号码不能为空';
                    if (!phoneValidatorRegex.hasMatch(val!)) return '手机格式不正确';
                    return null;
                  },
                ),
                itemSpace,
                Stack(alignment: Alignment.centerRight, children: [
                  TextFormField(
                    key: const ValueKey('captcha'),
                    onSaved: (String? val) => _verifyCode = val,
                    decoration: InputDecoration(
                        hintText: '请输入验证码',
                        hintStyle: themeData.textTheme.subtitle1
                            ?.copyWith(color: Colors.grey)),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (String? val) {
                      if (val?.isEmpty ?? true) return '验证码不能为空';
                      return null;
                    },
                  ),
                  BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
                    var enbleResend = ((_phone?.isNotEmpty ?? false) &&
                        phoneValidatorRegex.hasMatch(_phone ?? ''));
                    return (state is TimerRunInProgress)
                        ? Text('重发(${state.duration}秒)')
                        : GestureDetector(
                            child: Text(
                              '获取验证码',
                              style: themeData.textTheme.button?.copyWith(
                                  color:
                                      enbleResend ? Colors.blue : Colors.grey),
                            ),
                            onTap: enbleResend
                                ? () {
                                    BlocProvider.of<UserBloc>(context).add(
                                        UserSendSmsVerifyCodeRequested(
                                            _phone!, () {
                                      showToast('验证码已发送，请注意查收');
                                    }));
                                  }
                                : null,
                          );
                  }),
                ]),
                itemSpace,
                TextFormField(
                  controller: _passController,
                  key: const ValueKey('password'),
                  onSaved: (String? val) => _password = val,
                  decoration: InputDecoration(
                      hintText: '请输入新密码',
                      hintStyle: themeData.textTheme.subtitle1
                          ?.copyWith(color: Colors.grey)),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? val) {
                    if (val?.isEmpty ?? true) return '新密码不能为空';
                    if (val!.length < 8 || val.length > 20) return '密码长度为8-20位';
                    return null;
                  },
                ),
                itemSpace,
                TextFormField(
                  key: const ValueKey('confirmPassword'),
                  decoration: InputDecoration(
                      hintText: '请再次输入新密码',
                      hintStyle: themeData.textTheme.subtitle1
                          ?.copyWith(color: Colors.grey)),
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? val) {
                    if (val?.isEmpty ?? true) return '确认新密码不能为空';
                    if (val != _passController.text) return '两次输入新密码不一致';
                    return null;
                  },
                ),
                itemSpace,
                BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) =>
                        state.status == FormStatus.submissionInProgress
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(
                                  key: const ValueKey('nextStep'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      onPrimary: Colors.white,
                                      shape: const StadiumBorder()),
                                  child: const Text('确认'),
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      _formKey.currentState?.save();
                                      BlocProvider.of<UserBloc>(context).add(
                                          UserResetPasswordRequested(
                                              _phone!,
                                              _password!,
                                              _verifyCode!, () {
                                        showToast('重置密码成功');
                                        Navigator.of(context).pop();
                                      }));
                                    }
                                  },
                                ),
                              )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormChange() {
    if (_formChanged) return;
    setState(() {
      _formChanged = true;
    });
  }

  Future<bool> _onWillPop() {
    if (!_formChanged) return Future<bool>.value(true);
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('确定放弃找回密码吗?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Text('取消'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.black),
              child: const Text('放弃'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
