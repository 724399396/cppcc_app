import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../widget/message_list_item.dart';
import 'package:cppcc_app/utils/routes.dart';

import 'package:cppcc_app/dto/message/message_entity.dart';
import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: Color(0xffffffff),
                indicatorWeight: 1,
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

// 名片消息页面
class VisitingCardMessage extends StatelessWidget {
  late EasyRefreshController _controller = EasyRefreshController();
  late ScrollController _scrollController = ScrollController();
  // Header浮动
  bool _headerFloat = false;
  // 是否开启刷新
  bool _enableRefresh = true;
  // 是否开启加载
  bool _enableLoad = true;

  // 信息列表
  late List<MessageRecords> _msgList = [];

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xffffffff),
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            _msgList.addAll(state.listDatas.toList());
            return EasyRefresh.custom(
              emptyWidget: state.listDatas.length == 0
                  ? Container(
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(),
                            flex: 2,
                          ),
                          // SizedBox(
                          //   width: 100.0,
                          //   height: 100.0,
                          //   child: new Image.asset('assets/icons/ic_wode_selected.png'),
                          // ),
                          Text(
                            "未加载到数据",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.grey[400]),
                          ),
                          Expanded(
                            child: SizedBox(),
                            flex: 3,
                          ),
                        ],
                      ),
                    )
                  : null,
              firstRefresh: true,
              header: _enableRefresh
                  ? ClassicalHeader(
                      textColor: Colors.black,
                      infoColor:
                          _headerFloat ? Colors.black87 : Color(0xffbee0ff),
                      float: _headerFloat,
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
                      textColor: Colors.black,
                      infoColor:
                          _headerFloat ? Colors.black87 : Color(0xffbee0ff),
                      float: _headerFloat,
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
                      _msgList = [];
                      BlocProvider.of<MessageBloc>(context)
                          .add(GetListData(1, state.pageSize));
                      _controller.resetLoadState();
                      _controller.finishRefresh();
                    }
                  : null,
              onLoad: _enableLoad
                  ? () async {
                      await Future.delayed(Duration(seconds: 2), () {
                        BlocProvider.of<MessageBloc>(context)
                            .add(GetListData(state.pageNo + 1, state.pageSize));

                        _controller.finishLoad();
                      });
                    }
                  : null,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return MessageListItem(
                        icon: Icon(Icons.chevron_right, color: Colors.grey),
                        title: state.listDatas[index].titile,
                        createTime: state.listDatas[index].sendTime,
                        describe: state.listDatas[index].msgAbstract,
                        titleColor: Color(0xff5d5d5d),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              Routes.messageDetailsPage,
                              arguments: {"msgID": state.listDatas[index].id});
                        },
                      );
                    },
                    childCount: state.listDatas.length,
                  ),
                ),
              ],
            );
          },
        ));
  }
}

// 系统消息
class SystemMessage extends StatelessWidget {
  late EasyRefreshController _controller = EasyRefreshController();
  late ScrollController _scrollController = ScrollController();
  // Header浮动
  bool _headerFloat = false;
  // 是否开启刷新
  bool _enableRefresh = true;
  // 是否开启加载
  bool _enableLoad = true;

  // 信息列表
  late List<MessageRecords> _msgList = [];

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xffffffff),
        child: BlocBuilder<MessageBloc, MessageState>(
          builder: (context, state) {
            _msgList.addAll(state.listDatas.toList());
            return EasyRefresh.custom(
              emptyWidget: state.listDatas.isEmpty
                  ? SizedBox(
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Expanded(
                            child: SizedBox(),
                            flex: 2,
                          ),
                          Text(
                            "未加载到数据",
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.grey[400]),
                          ),
                          const Expanded(
                            child: SizedBox(),
                            flex: 3,
                          ),
                        ],
                      ),
                    )
                  : null,
              firstRefresh: true,
              header: _enableRefresh
                  ? ClassicalHeader(
                      infoColor:
                          _headerFloat ? Colors.black87 : Color(0xffbee0ff),
                      float: _headerFloat,
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
                      infoColor:
                          _headerFloat ? Colors.black87 : Color(0xffbee0ff),
                      float: _headerFloat,
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
                      _msgList = [];
                      BlocProvider.of<MessageBloc>(context)
                          .add(GetListData(1, state.pageSize));
                      _controller.resetLoadState();
                      _controller.finishRefresh();
                    }
                  : null,
              onLoad: _enableLoad
                  ? () async {
                      await Future.delayed(Duration(seconds: 2), () {
                        BlocProvider.of<MessageBloc>(context)
                            .add(GetListData(state.pageNo + 1, state.pageSize));

                        _controller.finishLoad();
                      });
                    }
                  : null,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return MessageListItem(
                        icon: Icon(Icons.chevron_right, color: Colors.grey),
                        title: state.listDatas[index].titile,
                        createTime: state.listDatas[index].sendTime,
                        describe: state.listDatas[index].msgAbstract,
                        titleColor: Color(0xff5d5d5d),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              Routes.messageDetailsPage,
                              arguments: {"msgID": state.listDatas[index].id});
                        },
                      );
                    },
                    childCount: state.listDatas.length,
                  ),
                ),
              ],
            );
          },
        ));
  }
}
