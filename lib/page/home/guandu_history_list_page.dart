import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/dict.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/posts_list_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuanduHistoryListPage extends StatefulWidget {
  const GuanduHistoryListPage({Key? key}) : super(key: key);

  @override
  State<GuanduHistoryListPage> createState() => _GuanduHistoryListPageState();
}

class _GuanduHistoryListPageState extends State<GuanduHistoryListPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<Dict>? _tabs;
  late TabController _tabController;

  @override
  @protected
  bool get wantKeepAlive => true;

  void updateTab(Map<String, List<Dict>> dictMap) {
    _tabs = dictMap['gd_history_dict']
        ?.where((element) => element.itemValue == '1')
        .toList();
    _tabController =
        TabController(initialIndex: 0, length: _tabs?.length ?? 0, vsync: this);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var dictMap =
        BlocProvider.of<AppSettingBloc>(context, listen: false).state.dictMap;
    updateTab(dictMap);
    return BlocListener<AppSettingBloc, AppSettingState>(
      listener: (context, state) {
        setState(() {
          updateTab(state.dictMap);
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('官渡文史'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(Routes.guanduHistoricalClueListPage);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    child: const Text(
                      '史料征集',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
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
          children: _tabs?.map<Widget>((item) {
                return PostsListContainer(
                    PostKey(PostType.guanduHistory, int.parse(item.itemValue)));
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
