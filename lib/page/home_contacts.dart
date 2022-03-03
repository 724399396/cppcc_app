import 'package:flutter/material.dart';

class HomeContacts extends StatefulWidget {
  const HomeContacts({Key? key}) : super(key: key);

  @override
  _HomeContactsState createState() => _HomeContactsState();
}

class _HomeContactsState extends State<HomeContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "通讯录",
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
