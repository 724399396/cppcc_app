import 'package:flutter/material.dart';

class VisitingCardPage extends StatefulWidget {
  const VisitingCardPage({Key? key}) : super(key: key);

  @override
  _VisitingCardPageState createState() => _VisitingCardPageState();
}

class _VisitingCardPageState extends State<VisitingCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "二维码名片",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff27f56),
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Text("test"),
        ],
      ),
    );
  }
}
