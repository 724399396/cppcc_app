import 'package:cppcc_app/bloc/timer_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePhonePage extends StatefulWidget {
  const UpdatePhonePage({Key? key}) : super(key: key);

  @override
  State<UpdatePhonePage> createState() => _UpdatePhonePageState();
}

class _UpdatePhonePageState extends State<UpdatePhonePage> {
  bool _formChanged = false;
  String? _phone;
  String? _verifyCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    var phoneValidatorRegex = RegExp(r"^[0-9]{11}$");
    const itemSpace = SizedBox(height: 20);
    return Scaffold(
      appBar: AppBar(
        title: const Text('修改手机号'),
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
                                        UserSendSmsVerifyCodeRequested(_phone!,
                                            () {
                                      showToast('验证码已发送，请注意查收');
                                    }));
                                  }
                                : null,
                          );
                  }),
                ]),
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
                                          UserUpdatePhoneRequested(
                                              _phone!, _verifyCode!, () {
                                        showToast('修改手机号成功');
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
          content: const Text('确定放弃修改手机号码吗?'),
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
