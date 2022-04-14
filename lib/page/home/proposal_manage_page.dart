import 'package:flutter/material.dart';

class ProposalManagePage extends StatefulWidget {
  const ProposalManagePage({Key? key}) : super(key: key);

  @override
  _ProposalManagePageState createState() => _ProposalManagePageState();
}

class _ProposalManagePageState extends State<ProposalManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "提案管理",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xfff27f56),
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: const [
          Text("功能开发中"),
        ],
      ),
    );
  }
}
