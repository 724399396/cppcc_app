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
        title: const Text("提案管理"),
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
