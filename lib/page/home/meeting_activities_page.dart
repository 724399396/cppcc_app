import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/models/dict.dart';
import 'package:cppcc_app/models/meeting.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/meeting_list_item.dart';
import 'package:flutter/material.dart';
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
    return BlocEasyFrefresh<MeetingBloc, MeetingState, Meeting>(
        (state) => state.meetings[type] ?? [], () async {
      BlocProvider.of<MeetingBloc>(context).add(MeetingLoadMore(type));
    }, () async {
      BlocProvider.of<MeetingBloc>(context).add(MeetingRefresh(type));
    }, (p) => MeetingItem(p),
        prefix: type == '1'
            ? SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.twoMeetingPage);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Image.asset(
                      'assets/bg/bg_two_meetings.png',
                      width: double.infinity,
                    ),
                  ),
                ),
              )
            : null);
  }
}
