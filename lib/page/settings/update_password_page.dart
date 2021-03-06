import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  bool _formChanged = false;
  String? _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    const itemSpace = SizedBox(height: 20);

    return Scaffold(
      appBar: AppBar(
        title: const Text('修改密码'),
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
                                          UserUpdatePasswordRequested(
                                              _password!, () {
                                        showToast('修改密码成功，请重新登录');
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                Routes.loginPage, (r) => false);
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
          content: const Text('确定放弃修改密码吗?'),
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
