import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cppcc_app/utils/routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("设置"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 12),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => {
                  Navigator.of(context).pushNamed(Routes.updatePasswordPage),
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text("修改密码",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff000033),
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 16.0,
                        child: Icon(Icons.chevron_right, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  var confirm = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text('确认退出?'),
                        actions: <Widget>[
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.black),
                            child: const Text('取消'),
                            onPressed: () => Navigator.of(context).pop(false),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(primary: Colors.black),
                            child: const Text('确认'),
                            onPressed: () => Navigator.of(context).pop(true),
                          ),
                        ],
                      );
                    },
                  );
                  if (confirm ?? false) {
                    BlocProvider.of<UserBloc>(context)
                        .add(const UserLogoutRequested());
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        Routes.loginPage, (r) => false);
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                  width: double.infinity,
                  color: Colors.white,
                  child: const Center(
                      child: Text("退出登录",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff000033),
                          ))),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
