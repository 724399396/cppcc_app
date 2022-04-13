import 'package:cppcc_app/bloc/opinion_bloc.dart';
import 'package:cppcc_app/models/opinions.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/opinion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cppcc_app/utils/list_data_fetch_status.dart';

class SocialOpinionsPage extends StatefulWidget {
  const SocialOpinionsPage({Key? key}) : super(key: key);

  @override
  _SocialOpinionsPageState createState() => _SocialOpinionsPageState();
}

class _SocialOpinionsPageState extends State<SocialOpinionsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  List<OpinionListType> _tabs = [];

  @override
  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabs = [OpinionListType.notFinished, OpinionListType.finished];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "社情民意",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xfff27f56),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.white,
              indicatorColor: const Color(0xffffffff),
              indicatorWeight: 1,
              tabs: _tabs.map((item) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    item.description,
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
        children: _tabs.map((item) {
          return OpinionList(
            tabData: item,
          );
        }).toList(),
      ),
    );
  }
}

// 列表信息
class OpinionList extends StatelessWidget {
  final _easyRefreshController = EasyRefreshController();
  final OpinionListType _listType;
  OpinionList({Key? key, required tabData})
      : _listType = tabData,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff4f4f4),
      child: BlocConsumer<OpinionBloc, OpinionState>(
        buildWhen: (previous, current) =>
            previous.opitions != current.opitions ||
            previous.status != current.status,
        listenWhen: (previous, current) =>
            previous.opitions != current.opitions ||
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
        builder: (context, state) {
          var data = state.opitions[_listType] ?? [];
          return EasyRefresh.custom(
            controller: _easyRefreshController,
            enableControlFinishRefresh: true,
            enableControlFinishLoad: true,
            header: easyRefreshHeader,
            footer: easyRefreshFooter,
            onLoad: () async {
              BlocProvider.of<OpinionBloc>(context)
                  .add(OpinionLoadMore(_listType));
            },
            onRefresh: () async {
              BlocProvider.of<OpinionBloc>(context)
                  .add(OpinionRefresh(_listType));
            },
            emptyWidget:
                data.isEmpty ? const Center(child: Text('暂无数据')) : null,
            slivers: data.map((p) => OpinionItem(p)).toList(),
          );
        },
      ),
      // ),
    );
  }
}
