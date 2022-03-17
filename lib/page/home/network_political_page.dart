// class NetworkPoliticalPage extends StatefulWidget {
import 'dart:async';

import 'package:cppcc_app/bloc/discuss_network_bloc.dart';
import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/widget/discuss_network_list_item.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/mailbox_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cppcc_app/models/app_settings.dart';

import '../../utils/routes.dart';

class NetworkPoliticalPage extends StatefulWidget {
  const NetworkPoliticalPage({Key? key}) : super(key: key);

  @override
  _NetworkPoliticalPageState createState() => _NetworkPoliticalPageState();
}

class _NetworkPoliticalPageState extends State<NetworkPoliticalPage>
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
        .getDictItemByCode(DictService().discussNetworkStatus)
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
          "网络议政",
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
                return NetworkPoliticalContentPage(codeType: item["code"]);
              }).toList(),
      ),
    );
  }
}

// 列表信息
// ignore: must_be_immutable
class NetworkPoliticalContentPage extends StatelessWidget {
  String codeType;
  NetworkPoliticalContentPage({Key? key, required this.codeType})
      : super(key: key);

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
        child: BlocBuilder<DiscussNetworkBloc, DiscussNetworkState>(
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
                      BlocProvider.of<DiscussNetworkBloc>(context).add(
                          GetDiscussNetworkData(1, state.pageSize, codeType));
                      _controller.resetLoadState();
                      _controller.finishRefresh();
                    }
                  : null,
              onLoad: _enableLoad
                  ? () async {
                      BlocProvider.of<DiscussNetworkBloc>(context).add(
                          GetDiscussNetworkData(
                              state.pageNo + 1, state.pageSize, codeType));
                      _controller.resetLoadState();
                      _controller.finishLoad();
                    }
                  : null,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return DiscussNetworkListItem(state.listDatas[index]);
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
