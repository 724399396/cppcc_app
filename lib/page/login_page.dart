import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/discuss_network_bloc.dart';
import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/bloc/opinion_bloc.dart';
import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/bloc/proposal_bloc.dart';
import 'package:cppcc_app/bloc/two_meetings_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/styles.dart';
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
    const itemSpace = SizedBox(height: 32);
    const formItemSpace = SizedBox(height: 16);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg/bg_dl.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft,
            ),
          ),
          Center(
            child: Column(
              children: [
                SizedBox(height: itemSpace.height! * 1.5),
                const Text("手机登录",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                itemSpace,
                Image.asset(
                  'assets/icons/ic_logo_dl.png',
                  width: deviceSize.width / 3,
                  fit: BoxFit.contain,
                ),
                itemSpace,
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    onChanged: _onFormChange,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) => TextFormField(
                              key: const ValueKey('username'),
                              initialValue: state.userInfo?.phone,
                              onSaved: (String? val) => _username = val,
                              decoration: InputDecoration(
                                  prefixIconConstraints: const BoxConstraints(
                                      maxHeight: 24, minWidth: 48),
                                  prefixIcon: Image.asset(
                                    'assets/icons/ic_shoujih.png',
                                  ),
                                  hintText: '请输入手机号',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      ?.copyWith(color: Colors.grey)),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? val) {
                                if (val?.isEmpty ?? true) return '手机号不能为空';
                                return null;
                              },
                            ),
                          ),
                          formItemSpace,
                          TextFormField(
                            key: const ValueKey('password'),
                            onSaved: (String? val) => _password = val,
                            decoration: InputDecoration(
                                prefixIconConstraints: const BoxConstraints(
                                    maxHeight: 24, minWidth: 48),
                                prefixIcon: Image.asset(
                                  'assets/icons/ic_mima.png',
                                ),
                                hintText: '请输入密码',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(color: Colors.grey)),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (String? val) {
                              if (val?.isEmpty ?? true) return '密码不能为空';
                              return null;
                            },
                          ),
                          formItemSpace,
                          BlocBuilder<UserBloc, UserState>(
                            builder: (context, state) => state.status ==
                                    FormStatus.submissionInProgress
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      key: const ValueKey('login'),
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                      child: const Text('登录',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)),
                                      onPressed: () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          _formKey.currentState?.save();
                                          BlocProvider.of<UserBloc>(context)
                                              .add(UserLoginRequested(
                                                  _username!, _password!, () {
                                            // 初始化首页需要数据
                                            BlocProvider.of<AppSettingBloc>(
                                                    context)
                                                .add(AppSettingInitlized());
                                            BlocProvider.of<PostsBloc>(context)
                                                .add(PostInitilized());
                                            BlocProvider.of<OpinionBloc>(
                                                    context)
                                                .add(OpinionInitilized());
                                            BlocProvider.of<ProposalBloc>(
                                                    context)
                                                .add(ProposalInitialied());
                                            BlocProvider.of<MeetingBloc>(
                                                    context)
                                                .add(MeetingInitilized());
                                            BlocProvider.of<DiscussNetworkBloc>(
                                                    context)
                                                .add(
                                                    DiscussNetworkInitilized());
                                            BlocProvider.of<MailboxBloc>(
                                                    context)
                                                .add(MailboxInitilized());
                                            BlocProvider.of<TwoMeetingsBloc>(
                                                    context)
                                                .add(TwoMeetingsInitilized());
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
                          formItemSpace,
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
                                  '忘记密码?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(color: AppColors.appBlue),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
