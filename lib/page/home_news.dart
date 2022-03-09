import 'dart:async';

import 'package:cppcc_app/bloc/news_bloc.dart';
import 'package:cppcc_app/dto/news/news_entity.dart';
import 'package:cppcc_app/widget/news_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../widget/message_list_item.dart';
import 'package:cppcc_app/utils/routes.dart';

import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cppcc_app/bloc/news_topic_bloc.dart';
import 'package:cppcc_app/widget/general_search.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  _HomeNewsState createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Container(
            height: 1,
            child: Image.asset(
              'assets/bg/bg_news.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, left: 15, right: 15),
              child: GeneralSearch(),
            ),
            Container(
                height: 48,
                child: BlocBuilder<NewsTopicBloc, NewsTopicState>(
                  builder: (context, state) {
                    return EasyRefresh.custom(
                      scrollDirection: Axis.horizontal,
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return FlatButton(
                                onPressed: () {
                                  print("click");
                                },
                                padding: EdgeInsets.all(1.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: Color(0xffffffff)),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        state.listDatas[index].itemText,
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Color(0xffffffff)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: state.listDatas.length,
                          ),
                        ),
                      ],
                    );
                  },
                )),
            Expanded(
                child: Container(
              width: double.maxFinite,
              // child: Text("0"),
              child: NewsContentPage(),
            )),
          ],
        ),
      ],
    );
  }
}

// 资讯详询
class NewsContentPage extends StatelessWidget {
  late EasyRefreshController _controller = EasyRefreshController();
  late ScrollController _scrollController = ScrollController();
  // Header浮动
  bool _headerFloat = false;
  // 是否开启刷新
  bool _enableRefresh = true;
  // 是否开启加载
  bool _enableLoad = true;

  // 信息列表
  late List<NewsRecords> _msgList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      child: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          _msgList.addAll(state.listDatas.toList());
          print("====listDatas====" + state.listDatas.length.toString());
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
                    bgColor: Color(0xffbee0ff),
                    infoColor: _headerFloat ? Colors.black87 : Colors.teal,
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
                    bgColor: Color(0xffbee0ff),
                    infoColor: _headerFloat ? Colors.black87 : Colors.teal,
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
                    BlocProvider.of<NewsBloc>(context)
                        .add(GetNewsListData(1, state.pageSize));
                    _controller.resetLoadState();
                    _controller.finishRefresh();
                  }
                : null,
            onLoad: _enableLoad
                ? () async {
                    await Future.delayed(Duration(seconds: 2), () {
                      BlocProvider.of<NewsBloc>(context)
                          .add(GetNewsListData(state.pageNo + 1, state.pageSize));

                      _controller.finishLoad();
                    });
                  }
                : null,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return NewsListItem(
                      icon: Icon(Icons.chevron_right, color: Colors.grey),
                      title: state.listDatas[index].title,
                      createTime: state.listDatas[index].title,
                      describe: state.listDatas[index].title,
                      titleColor: Color(0xff5d5d5d),
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.newsDetailsPage, arguments: {"id": state.listDatas[index].id});
                      },
                    );
                  },
                  childCount: state.listDatas.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
