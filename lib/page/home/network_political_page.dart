import 'package:flutter/material.dart';

class NetworkPoliticalPage extends StatefulWidget {
  const NetworkPoliticalPage({Key? key}) : super(key: key);

  @override
  _NetworkPoliticalPageState createState() => _NetworkPoliticalPageState();
}

class _NetworkPoliticalPageState extends State<NetworkPoliticalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "网络议政",
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
