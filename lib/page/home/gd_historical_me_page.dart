import 'dart:async';

import 'package:cppcc_app/bloc/historical_clue_bloc.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/historical_clue_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GdHistoricalClueMePage extends StatefulWidget {
  const GdHistoricalClueMePage({Key? key}) : super(key: key);

  @override
  _GdHistoricalClueMePageState createState() => _GdHistoricalClueMePageState();
}

class _GdHistoricalClueMePageState extends State<GdHistoricalClueMePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final List _tabs = [];
  late TabController _tabController;

  @override
  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "我的线索",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff27f56),
      ),
      body: GdHistoricalClueContentPage(),
    );
  }
}

// 列表信息
// ignore: must_be_immutable
class GdHistoricalClueContentPage extends StatelessWidget {
  GdHistoricalClueContentPage({Key? key}) : super(key: key);

  late final EasyRefreshController _controller = EasyRefreshController();
  late final ScrollController _scrollController = ScrollController();
  // Header浮动
  final bool _headerFloat = false;
  // 是否开启刷新
  final bool _enableRefresh = true;
  // 是否开启加载
  final bool _enableLoad = true;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xffffffff),
        child: BlocBuilder<HistoricalClueBloc, HistoricalClueState>(
          builder: (context, state) {
            return EasyRefresh.custom(
              emptyWidget: state.listDatas.isEmpty ? EmptyData() : null,
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
                      BlocProvider.of<HistoricalClueBloc>(context)
                          .add(GetHistoricalClueListData(1, state.pageSize));
                      _controller.resetLoadState();
                      _controller.finishRefresh();
                    }
                  : null,
              onLoad: _enableLoad
                  ? () async {
                      BlocProvider.of<HistoricalClueBloc>(context).add(
                          GetHistoricalClueListData(
                              state.pageNo + 1, state.pageSize));
                      _controller.resetLoadState();
                      _controller.finishLoad();
                    }
                  : null,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return HistoricalClueItem(state.listDatas[index]);
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
