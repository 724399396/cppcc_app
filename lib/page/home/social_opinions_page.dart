import 'package:flutter/material.dart';

class SocialOpinionsPage extends StatefulWidget {
  const SocialOpinionsPage({Key? key}) : super(key: key);

  @override
  _MSocialOpinionsPageState createState() => _MSocialOpinionsPageState();
}

class _MSocialOpinionsPageState extends State<SocialOpinionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "社情民意",
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
