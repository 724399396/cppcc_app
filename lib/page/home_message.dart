import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../widget/user_list_item.dart';
import 'package:cppcc_app/utils/routes.dart';

class HomeMessage extends StatelessWidget {

static List<Tab> tabs = [
    Tab(text: '名片消息',),
    Tab(text: "系统消息",),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "消息",
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
          VisitingCardMessage(),
          SystemMessage(),
        ]),
      ),
    );
  }
}



// 名片消息
class VisitingCardMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xffffffff),
        child: Text("名片消息"));
  }
}


// 系统消息
class SystemMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xffffffff),
        child: Text("系统消息"));
  }
}

