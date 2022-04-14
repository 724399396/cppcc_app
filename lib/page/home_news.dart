import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import '../bloc/news_topic_bloc.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  _HomeNewsState createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var moduleIconWidth = deviceSize.width / 8;
    var _easyRefreshController = EasyRefreshController();
    return SafeArea(
        child: Stack(alignment: Alignment.center, children: [
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
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            // TODO
            child:
                GeneralSearch(Colors.white, ((context, keyword) => {})),
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
                            return TextButton(
                              onPressed: () {
                                print("click");
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 0.5, color: Color(0xffffffff)),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      state.listDatas[index].itemText,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: const Color(0xffffffff)),
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
          // 文件公告和资讯
          Expanded(
            child: BlocConsumer<PostsBloc, PostsState>(
              buildWhen: (previous, current) =>
                  previous.news != current.news ||
                  previous.fileAnnments != current.fileAnnments ||
                  previous.status != current.status,
              listenWhen: (previous, current) =>
                  previous.news != current.news ||
                  previous.fileAnnments != current.fileAnnments ||
                  previous.status != current.status,
              listener: (previous, current) {
                // easy conller
                switch (current.status) {
                  case ListDataFetchStatus.normal:
                    _easyRefreshController.finishRefresh(success: true);
                    _easyRefreshController.finishLoad(success: true);
                    break;
                  case ListDataFetchStatus.refresh:
                    break;
                  case ListDataFetchStatus.loadMore:
                    break;
                  case ListDataFetchStatus.failure:
                    _easyRefreshController.finishRefresh(success: false);
                    _easyRefreshController.finishLoad(success: false);
                    break;
                }
              },
              builder: (context, state) => EasyRefresh.custom(
                controller: _easyRefreshController,
                enableControlFinishRefresh: true,
                enableControlFinishLoad: true,
                header: ClassicalHeader(
                  refreshText: '下拉刷新',
                  refreshReadyText: '释放刷新',
                  refreshingText: '加载中',
                  refreshedText: '加载完成',
                  refreshFailedText: '加载失败',
                  noMoreText: '没有更多数据',
                  infoText: '更新于 %T',
                  textColor: Colors.black,
                ),
                footer: ClassicalFooter(
                  loadText: '上拉加载更多',
                  loadReadyText: '释放刷新',
                  loadingText: '加载中',
                  loadedText: '加载完成',
                  loadFailedText: '加载失败',
                  noMoreText: '没有更多数据',
                  infoText: '更新于 %T',
                  textColor: Colors.black,
                ),
                onLoad: () async {
                  BlocProvider.of<PostsBloc>(context).add(HomePostLoadMore());
                },
                onRefresh: () async {
                  BlocProvider.of<PostsBloc>(context).add(HomePostRefresh());
                },
                emptyWidget: (state.news + state.fileAnnments).isEmpty
                    ? const Center(child: Text('暂无数据'))
                    : null,
                slivers: (state.news + state.fileAnnments)
                    .map((p) => PostsItem(p))
                    .toList(),
              ),
            ),
            // ),
          ),
        ],
      ),
    ]));
  }
}
