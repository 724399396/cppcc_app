import 'package:cppcc_app/bloc/discuss_network_bloc.dart';
import 'package:cppcc_app/models/discuss_network.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/discuss_network_item.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DicusssNetworkPage extends StatefulWidget {
  const DicusssNetworkPage({Key? key}) : super(key: key);

  @override
  _DicusssNetworkPageState createState() => _DicusssNetworkPageState();
}

class _DicusssNetworkPageState extends State<DicusssNetworkPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<DiscussNetworkListType>? _tabs;
  late TabController _tabController;

  @override
  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _tabs = [
      DiscussNetworkListType.notFinished,
      DiscussNetworkListType.finished
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("网络议政"),
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
              tabs: _tabs?.map((item) {
                    return Container(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Text(
                        item.description,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    );
                  }).toList() ??
                  [],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs?.map((item) {
              return DiscussNetworkContentPage(type: item);
            }).toList() ??
            [],
      ),
    );
  }
}

// 列表信息
class DiscussNetworkContentPage extends StatelessWidget {
  final DiscussNetworkListType type;
  const DiscussNetworkContentPage({Key? key, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _easyRefreshController = EasyRefreshController();
    BlocProvider.of<DiscussNetworkBloc>(context)
        .add(DiscussNetworkFirstFetch(type));
    return BlocConsumer<DiscussNetworkBloc, DiscussNetworkState>(
      buildWhen: (previous, current) =>
          previous.data != current.data || previous.status != current.status,
      listenWhen: (previous, current) =>
          previous.data != current.data || previous.status != current.status,
      listener: (previous, current) {
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
        var data = state.data[type];
        return EasyRefresh.custom(
          controller: _easyRefreshController,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          header: easyRefreshHeader,
          footer: easyRefreshFooter,
          onLoad: () async {
            BlocProvider.of<DiscussNetworkBloc>(context)
                .add(DiscussNetworkLoadMore(type));
          },
          onRefresh: () async {
            BlocProvider.of<DiscussNetworkBloc>(context)
                .add(DiscussNetworkRefresh(type));
          },
          emptyWidget: (data?.isEmpty ?? true) ? const EmptyData() : null,
          slivers:
              data?.map<Widget>((p) => DiscussNetworkItem(p)).toList() ?? [],
        );
      },
    );
  }
}
