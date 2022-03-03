import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../widget/message_list_item.dart';
import 'package:cppcc_app/utils/routes.dart';

class HomeNews extends StatelessWidget {
  static List<Tab> tabs = [
    Tab(
      text: '政协会议',
    ),
    Tab(
      text: "政协工作",
    ),
    Tab(
      text: "党派团体",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "新闻资讯",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color(0xfff27f56),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(44),
            child: Theme(
              data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
              child: TabBar(
                tabs: tabs,
                labelColor: Colors.white,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontSize: 15),
                unselectedLabelColor: Colors.white,
              ),
            ),
          ),
        ),
        body: TabBarView(children: [
          Text("data"),
          Text("data"),
          Text("data"),
        ]),
      ),
    );
  }
}
