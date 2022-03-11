import 'package:flutter/material.dart';

class MemberStudyPage extends StatefulWidget {
  const MemberStudyPage({Key? key}) : super(key: key);

  @override
  _MemberStudyPageState createState() => _MemberStudyPageState();
}

class _MemberStudyPageState extends State<MemberStudyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "委员学习",
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
