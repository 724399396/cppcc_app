import 'package:flutter/material.dart';

class ArchivesPage extends StatefulWidget {
  const ArchivesPage({Key? key}) : super(key: key);

  @override
  _ArchivesPageState createState() => _ArchivesPageState();
}

class _ArchivesPageState extends State<ArchivesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "履职档案",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff27f56),
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Text("功能开发中-当前页面舍弃"),
        ],
      ),
    );
  }
}
