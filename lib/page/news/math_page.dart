import 'package:flutter/material.dart';

class MathPage extends StatefulWidget {
  String title;
  MathPage(this.title);
  @override
  _MathPageState createState() => _MathPageState();
}

class _MathPageState extends State<MathPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView.builder(itemBuilder: (build, index) {
      return Text("${widget.title} --- $index");
    }));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
