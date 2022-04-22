// ignore_for_file: unused_import

import 'package:cppcc_app/bloc/guandu_historical_clue_bloc.dart';
import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/historical_clue_item.dart';
import 'package:cppcc_app/widget/posts_list_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class GuanduHistoralcalClueContainer extends StatefulWidget {
  const GuanduHistoralcalClueContainer({Key? key}) : super(key: key);

  @override
  State<GuanduHistoralcalClueContainer> createState() =>
      _GuanduHistoralcalClueContainerState();
}

class _GuanduHistoralcalClueContainerState
    extends State<GuanduHistoralcalClueContainer>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<String> _tabs;
  late TabController _tabController;
  bool filterSelf = false;

  @override
  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabs = ['史料征集公告', '史料线索提供'];
    _tabController =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('史料征集'),
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
                    item,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: _tabController.index == 1
          ? Stack(
              children: [
                FloatingActionButton.extended(
                  heroTag: 'mine',
                  icon: const Icon(Icons.my_library_books_outlined),
                  backgroundColor: const Color(0xfff27f56),
                  foregroundColor: Colors.white,
                  label: Text(filterSelf ? "全部" : "我的"),
                  onPressed: () {
                    setState(() {
                      filterSelf = !filterSelf;
                    });
                  },
                ),
                Container(
                    margin: const EdgeInsets.only(top: 52, bottom: 5),
                    child: FloatingActionButton.extended(
                      heroTag: 'add',
                      icon: const Icon(Icons.add),
                      backgroundColor: const Color(0xfff33333),
                      foregroundColor: Colors.white,
                      label: const Text("新增"),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(Routes.gdHistoricalAddPage);
                      },
                    )),
              ],
            )
          : Container(),
      body: TabBarView(
        controller: _tabController,
        children: [
          const PostsListContainer(PostKey(PostType.guanduHistory, 2)),
          GuanduHistoricalClueListPage(filterSelf),
        ],
      ),
    );
  }
}

class GuanduHistoricalClueListPage extends StatelessWidget {
  final bool filterSelf;
  const GuanduHistoricalClueListPage(this.filterSelf, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GuanduHistoricalClueBloc>(context)
        .add(GuanduHistoricalClueFirstFetch());
    var _easyRefreshController = EasyRefreshController();
    return SafeArea(
      child:
          BlocConsumer<GuanduHistoricalClueBloc, GuanduHistoricalClueState>(
        buildWhen: (previous, current) =>
            previous.data != current.data ||
            previous.status != current.status,
        listenWhen: (previous, current) =>
            previous.data != current.data ||
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
          var data = filterSelf
              ? state.data.where((element) =>
                  element.createBy ==
                  BlocProvider.of<UserBloc>(context).state.userInfo?.username)
              : state.data;
          return EasyRefresh.custom(
            controller: _easyRefreshController,
            enableControlFinishRefresh: true,
            enableControlFinishLoad: true,
            header: easyRefreshHeader,
            footer: easyRefreshFooter,
            onLoad: () async {
              BlocProvider.of<GuanduHistoricalClueBloc>(context)
                  .add(GuanduHistoricalClueLoadMore());
            },
            onRefresh: () async {
              BlocProvider.of<GuanduHistoricalClueBloc>(context)
                  .add(GuanduHistoricalClueRefresh());
            },
            emptyWidget: data.isEmpty ? const EmptyData() : null,
            slivers: data.map((p) => HistoricalClueItem(p)).toList(),
          );
        },
      ),
    );
  }
}
