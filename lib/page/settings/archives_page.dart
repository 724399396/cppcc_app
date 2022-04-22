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
        title: const Text("履职档案"),
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
