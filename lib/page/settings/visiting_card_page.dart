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
        title: const Text("二维码名片"),
      ),
      body: const Text("功能开发中"),
    );
  }
}
