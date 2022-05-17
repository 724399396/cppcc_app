import 'package:cppcc_app/models/proposal.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class ReplyDetailsPage extends StatelessWidget {
  const ReplyDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReplyFile _bean = ModalRoute.of(context)?.settings.arguments as ReplyFile;
    return Scaffold(
        appBar: AppBar(
          title: const Text("详情"),
        ),
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              child: Text(_bean.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xff333333),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _bean.authorRealname,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Color(0xff999999),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    DateFormat('yyyy-MM-dd').format(_bean.createTime),
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Color(0xff999999),
                    ),
                  ),
                ],
              ),
            ),
            // 顶部栏
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: _bean.content != ""
                  ? Html(
                      data: _bean.content,
                      tagsList: Html.tags..addAll(["bird", "flutter"]),
                    )
                  : Container(),
            )
          ],
        ));
  }
}
