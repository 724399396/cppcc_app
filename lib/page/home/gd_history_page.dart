import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cppcc_app/models/app_settings.dart';

import '../../bloc/posts_bloc.dart';
import '../../utils/list_data_fetch_status.dart';
import '../../widget/posts_item.dart';

class GdHistoryPage extends StatefulWidget {
  const GdHistoryPage({Key? key}) : super(key: key);

  @override
  _GdHistoryPageState createState() => _GdHistoryPageState();
}

class _GdHistoryPageState extends State<GdHistoryPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final List _tabs = [];
  late TabController _tabController;

  @override
  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //初始化标题头
    DictService()
        .getDictItemByCode(DictService().gdHistoryDict)
        .then((datas) => {
              setState(() {
                for (var item in datas) {
                  _tabs.add({"title": item.itemText, "code": item.itemValue});
                }
                _tabController = TabController(
                    initialIndex: 1, length: _tabs.length, vsync: this);
                _tabController.animateTo(0);
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "官渡文史",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff27f56),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.white,
              indicatorColor: Color(0xffffffff),
              indicatorWeight: 1,
              tabs: _tabs.map((item) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    item["title"],
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.isEmpty
            ? []
            : _tabs.map((item) {
                return HistoryContentPage(codeType: item["code"]);
              }).toList(),
      ),
    );
  }
}

// 列表信息
// ignore: must_be_immutable
class HistoryContentPage extends StatelessWidget {
  final _easyRefreshController = EasyRefreshController();
  String codeType;
  HistoryContentPage({Key? key, required this.codeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      child: BlocConsumer<PostsBloc, PostsState>(
        buildWhen: (previous, current) =>
            previous.learnings != current.learnings ||
            previous.status != current.status,
        listenWhen: (previous, current) =>
            previous.learnings != current.learnings ||
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
          emptyWidget: (state.learnings
                      .where((item) => item.category == int.parse(codeType)))
                  .isEmpty
              ? const Center(child: Text('暂无数据'))
              : null,
          slivers: (state.learnings
                  .where((item) => item.category == int.parse(codeType)))
              .map((p) => PostsItem(p))
              .toList(),
        ),
      ),
      // ),
    );
  }
}
