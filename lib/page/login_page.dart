import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _formChanged = false;
  String? _username;
  String? _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: Image.asset(
                  'assets/icons/ic_back.png',
                  height: 30,
                  width: 30,
                ),
                onPressed: () => Navigator.of(context).pop())
            : Container(),
        title: Text('登录',
            style: Theme.of(context)
                .primaryTextTheme
                .headline6
                ?.copyWith(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 16),
        child: ListView(
          children: [
            Image.asset(
              'assets/icons/ico_green.png',
              height: deviceSize.height / 6,
              fit: BoxFit.contain,
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: deviceSize.height / 4,
                  maxHeight: deviceSize.height / 3),
              child: Form(
                key: _formKey,
                onChanged: _onFormChange,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) => TextFormField(
                        key: const ValueKey('username'),
                        initialValue: state.username,
                        readOnly: state.username?.isNotEmpty ?? false,
                        onSaved: (String? val) => _username = val,
                        decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              'assets/icons/ic_user.png',
                              width: 40,
                              height: 40,
                            ),
                            hintText: '请输入用户名',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .subtitle1
                                ?.copyWith(color: Colors.grey)),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? val) {
                          if (val?.isEmpty ?? true) return '用户名/邮箱不能为空';
                          return null;
                        },
                      ),
                    ),
                    TextFormField(
                      key: const ValueKey('password'),
                      onSaved: (String? val) => _password = val,
                      decoration: InputDecoration(
                          prefixIcon: Image.asset(
                            'assets/icons/ic_mima.png',
                            width: 40,
                            height: 40,
                          ),
                          hintText: '请输入密码',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .subtitle1
                              ?.copyWith(color: Colors.grey)),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (String? val) {
                        if (val?.isEmpty ?? true) return '密码不能为空';
                        return null;
                      },
                    ),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) =>
                          state.status == FormStatus.submissionInProgress
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                    key: const ValueKey('login'),
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      onPrimary: Colors.white,
                                      shape: const StadiumBorder(),
                                    ),
                                    child: const Text('登录'),
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        _formKey.currentState?.save();
                                        BlocProvider.of<UserBloc>(context).add(
                                            UserLoginRequested(
                                                _username!, _password!, () {
                                          Navigator.of(context).canPop()
                                              ? Navigator.pop(context)
                                              : Navigator.of(context)
                                                  .pushReplacementNamed(
                                                      Routes.home);
                                        }));
                                      }
                                    },
                                  ),
                                ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(Routes.resetPasswordPage);
                          },
                          child: Text(
                            '找回密码',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
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
}
