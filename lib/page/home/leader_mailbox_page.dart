import 'package:flutter/material.dart';

class LeaderMailboxPage extends StatefulWidget {
  const LeaderMailboxPage({Key? key}) : super(key: key);

  @override
  _LeaderMailboxPageState createState() => _LeaderMailboxPageState();
}

class _LeaderMailboxPageState extends State<LeaderMailboxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "领导信箱",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff27f56),
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Text("功能开发中"),
        ],
      ),
    );
  }
}
