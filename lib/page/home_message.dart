import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../widget/message_list_item.dart';
import 'package:cppcc_app/utils/routes.dart';

class HomeMessage extends StatelessWidget {
  static List<Tab> tabs = [
    Tab(
      text: '名片消息',
    ),
    Tab(
      text: "系统消息",
    ),
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
  late EasyRefreshController _controller = EasyRefreshController();
  late ScrollController _scrollController = ScrollController();
  // 条目总数
  int _count = 20;
  // Header浮动
  bool _headerFloat = false;
  // 无限加载
  bool _enableInfiniteLoad = true;
  // 控制结束
  bool _enableControlFinish = false;
  // 是否开启刷新
  bool _enableRefresh = true;
  // 是否开启加载
  bool _enableLoad = true;
 

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffffffff),
      child: EasyRefresh.custom(
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        //任务独立
        taskIndependence: false,
          // 方向
        scrollDirection: Axis.vertical,
          // 顶部回弹
        topBouncing: true,
         // 底部回弹
        bottomBouncing: true,
        header: _enableRefresh
            ? ClassicalHeader(
                enableInfiniteRefresh: false,
                bgColor: Color(0xffbee0ff),
                infoColor: _headerFloat ? Colors.black87 : Colors.teal,
                float: _headerFloat,
                enableHapticFeedback: true,
                refreshText: "拉动刷新",
                refreshReadyText: "释放刷新",
                refreshingText: "正在刷新...",
                refreshedText: "刷新完成",
                refreshFailedText: "刷新失败",
                noMoreText: "没有更多数据",
                infoText: "更新于 %T",
              )
            : null,
        footer: _enableLoad
            ? ClassicalFooter(
                bgColor: Color(0xffbee0ff),
                infoColor: _headerFloat ? Colors.black87 : Colors.teal,
                enableInfiniteLoad: true,
                enableHapticFeedback: true,
                loadText: "拉动加载",
                loadReadyText: "释放加载",
                loadingText: "正在加载...",
                loadedText: "加载完成",
                loadFailedText: "加载失败",
                noMoreText: "没有更多数据",
                infoText: "更新于 %T",
              )
            : null,
        onRefresh: _enableRefresh
            ? () async {

               _controller.resetLoadState();
                    _controller.finishRefresh();

                await Future.delayed(Duration(seconds: 2), () {
                  // if (!_enableControlFinish) {
                    _controller.resetLoadState();
                    _controller.finishRefresh();
                  // }
                });
              }
            : null,
        onLoad: _enableLoad
            ? () async {
                await Future.delayed(Duration(seconds: 2), () {
                  print("加载");
                  if (!_enableControlFinish) {
                    _controller.finishLoad(noMore: _count >= 80);
                  }
                });
              }
            : null,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return MessageListItem(
                  icon: Image.asset(
                    'assets/icons/ic_shezhihdpi.png',
                  ),
                  title: "设置",
                  titleColor: Color(0xff5d5d5d),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.settingsPage);
                  },
                );
              },
              childCount: _count,
            ),
          ),
        ],
      ),
    );
  }
}

// 系统消息
class SystemMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(color: Color(0xffffffff), child: Text("系统消息"));
  }
}
