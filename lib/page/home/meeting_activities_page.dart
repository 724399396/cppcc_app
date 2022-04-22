import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/models/dict.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/meeting_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeetingActivitiesPage extends StatefulWidget {
  const MeetingActivitiesPage({Key? key}) : super(key: key);

  @override
  _MeetingActivitiesPageState createState() => _MeetingActivitiesPageState();
}

class _MeetingActivitiesPageState extends State<MeetingActivitiesPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<Dict>? _tabs;
  late TabController _tabController;

  @override
  @protected
  bool get wantKeepAlive => true;

  void updateTab(dictMap) {
    _tabs = dictMap['meeting_activity_type'];
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
          title: const Text("会议活动"),
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
        body: TabBarView(
          controller: _tabController,
          children: _tabs?.map((item) {
                return MeetingContentPage(type: item.itemValue);
              }).toList() ??
              [],
        ),
      ),
    );
  }
}

// 列表信息
class MeetingContentPage extends StatelessWidget {
  final String type;
  const MeetingContentPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MeetingBloc>(context).add(MeetingFirstFetch(type));
    final EasyRefreshController _easyRefreshController =
        EasyRefreshController();
    return BlocConsumer<MeetingBloc, MeetingState>(
      buildWhen: (previous, current) =>
          previous.meetings != current.meetings ||
          previous.status != current.status,
      listenWhen: (previous, current) =>
          previous.meetings != current.meetings ||
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
        var data = state.meetings[type] ?? [];
        return EasyRefresh.custom(
          controller: _easyRefreshController,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          header: easyRefreshHeader,
          footer: easyRefreshFooter,
          onLoad: () async {
            BlocProvider.of<MeetingBloc>(context).add(MeetingLoadMore(type));
          },
          onRefresh: () async {
            BlocProvider.of<MeetingBloc>(context).add(MeetingRefresh(type));
          },
          emptyWidget: data.isEmpty ? const EmptyData() : null,
          slivers: type == '1'
              ? [
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.twoMeetingPage);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Image.asset(
                          'assets/bg/bg_two_meetings.png',
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  ...data.map((p) => MeetingItem(p)).toList()
                ]
              : data.map((p) => MeetingItem(p)).toList(),
        );
      },
    );
  }
}
