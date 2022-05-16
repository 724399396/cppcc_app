import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/models/dict.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/mailbox_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cppcc_app/utils/routes.dart';

class LeaderMailboxPage extends StatefulWidget {
  const LeaderMailboxPage({Key? key}) : super(key: key);

  @override
  _LeaderMailboxPageState createState() => _LeaderMailboxPageState();
}

class _LeaderMailboxPageState extends State<LeaderMailboxPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<Dict>? _tabs;
  late TabController _tabController;

  @override
  @protected
  bool get wantKeepAlive => true;

  void updateTab(dictMap) {
    _tabs = dictMap["mailbox_type"];
    _tabController =
        TabController(initialIndex: 0, length: _tabs?.length ?? 0, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    var dictMap =
        BlocProvider.of<AppSettingBloc>(context, listen: false).state.dictMap;
    updateTab(dictMap);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<AppSettingBloc, AppSettingState>(
      listener: (context, state) {
        setState(() {
          updateTab(state.dictMap);
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text( "领导信箱"),
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
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                        child: Text(
                          item.itemText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          backgroundColor: const Color(0xfff27f56),
          foregroundColor: Colors.white,
          label: const Text("我要写信"),
          onPressed: () {
            Navigator.of(context).pushNamed(Routes.leaderMailboxAddPage);
          },
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabs?.map((item) {
                return MailboxContentPage(type: item.itemValue);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}

// 列表信息
class MailboxContentPage extends StatelessWidget {
  final String type;
  const MailboxContentPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EasyRefreshController _easyRefreshController =
        EasyRefreshController();
    BlocProvider.of<MailboxBloc>(context).add(MailboxFirstFetch(type));
    return Card(
        color: const Color(0xffffffff),
        child: BlocConsumer<MailboxBloc, MailboxState>(
          buildWhen: (previous, current) =>
              previous.data != current.data ||
              previous.status != current.status,
          listenWhen: (previous, current) =>
              previous.data != current.data ||
              previous.status != current.status,
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
                BlocProvider.of<MailboxBloc>(context)
                    .add(MailboxLoadMore(type));
              },
              onRefresh: () async {
                BlocProvider.of<MailboxBloc>(context).add(MailboxRefresh(type));
              },
              emptyWidget: (data?.isEmpty ?? true) ? const EmptyData() : null,
              slivers: data?.map((p) => MailboxListItem(p)).toList() ?? [],
            );
          },
        ));
  }
}
