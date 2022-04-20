import 'package:cppcc_app/styles.dart';
import 'package:flutter/material.dart';

class TwoMeetingsPage extends StatelessWidget {
  const TwoMeetingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //修改颜色
          ),
          title: const Text(
            "两会",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppColors.appOrange,
          elevation: 0.0,
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: const Text('功能开发中'),
        ));
  }
}
