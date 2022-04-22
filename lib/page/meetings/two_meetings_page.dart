import 'package:flutter/material.dart';

class TwoMeetingsPage extends StatelessWidget {
  const TwoMeetingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("两会"),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: const Text('功能开发中'),
        ));
  }
}
