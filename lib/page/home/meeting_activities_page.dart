import 'package:flutter/material.dart';

class MeetingActivitiesPage extends StatefulWidget {
  const MeetingActivitiesPage({Key? key}) : super(key: key);

  @override
  _MeetingActivitiesPageState createState() => _MeetingActivitiesPageState();
}

class _MeetingActivitiesPageState extends State<MeetingActivitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "会议活动",
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
