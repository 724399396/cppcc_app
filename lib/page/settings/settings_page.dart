import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/routes.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "设置",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff27f56),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xfff4f4f4),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              // print("====listDatas====" + state.listDatas.length.toString());
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 48,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text("修改密码",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff000033),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: const SizedBox(
                              height: 16.0,
                              width: 16.0,
                              child:
                                  Icon(Icons.chevron_right, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 48,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      margin: EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xffffffff),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text("系统通知",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Color(0xff000033),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: const SizedBox(
                              height: 16.0,
                              width: 16.0,
                              child:
                                  Icon(Icons.chevron_right, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('提示'),
                                content: Text('确认要退出登录吗？'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('取消'),
                                    onPressed: () {
                                      Navigator.of(context).pop('cancel');
                                    },
                                  ),
                                  TextButton(
                                    child: Text('确认'),
                                    onPressed: () {
                                      BlocProvider.of<UserBloc>(context)
                                          .add(UserLogoutRequested());
                                      Navigator.of(context).pop('ok');
                                      Navigator.of(context).pushNamed(Routes.loginPage);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        margin: EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xffffffff),
                        ),
                        child: Text("退出登录"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
