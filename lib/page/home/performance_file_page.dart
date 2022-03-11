import 'package:flutter/material.dart';

class PerformanceFilePage extends StatefulWidget {
  const PerformanceFilePage({Key? key}) : super(key: key);

  @override
  _PerformanceFilePageState createState() => _PerformanceFilePageState();
}

class _PerformanceFilePageState extends State<PerformanceFilePage> {
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
          Text("功能开发中"),
        ],
      ),
    );
  }
}
