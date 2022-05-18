import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/dict.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CommitteStudyPage extends StatefulWidget {
  const CommitteStudyPage({Key? key}) : super(key: key);

  @override
  State<CommitteStudyPage> createState() => _CommitteStudyPageState();
}

class _CommitteStudyPageState extends State<CommitteStudyPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<Dict>? _tabs;
  late TabController _tabController;

  @override
  @protected
  bool get wantKeepAlive => true;

  void updateTab(Map<String, List<Dict>> dictMap) {
    _tabs = dictMap['learning_categories'];
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
          title: const Text('委员学习'),
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
                return CommitteStudyListContainer(
                    PostKey(PostType.learning, int.parse(item.itemValue)));
              }).toList() ??
              [],
        ),
      ),
    );
  }
}

class CommitteStudyListContainer extends StatefulWidget {
  final PostKey postKey;
  const CommitteStudyListContainer(this.postKey, {Key? key}) : super(key: key);

  @override
  State<CommitteStudyListContainer> createState() =>
      _CommitteStudyListContainerState();
}

class _CommitteStudyListContainerState
    extends State<CommitteStudyListContainer> {
  String _searchKeyWord = "";

  @override
  Widget build(BuildContext context) {
    var _easyRefreshController = EasyRefreshController();
    BlocProvider.of<PostsBloc>(context).add(PostFirstFetch(widget.postKey));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(children: [
        GeneralSearch(
          AppColors.greyTextColor,
          (context, keyword) {
            setState(() {
              _searchKeyWord = keyword;
            });
          },
          initValue: _searchKeyWord,
          fillColor: Colors.white,
        ),
        Expanded(
            child: BlocConsumer<PostsBloc, PostsState>(
          buildWhen: (previous, current) =>
              previous.posts != current.posts ||
              previous.status != current.status,
          listenWhen: (previous, current) =>
              previous.posts != current.posts ||
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
            var data = state.posts[widget.postKey] ?? [];
            var filterData = (_searchKeyWord.isEmpty
                ? data
                : data.where((d) => d.title.contains(_searchKeyWord)).toList());
            return EasyRefresh.custom(
              controller: _easyRefreshController,
              enableControlFinishRefresh: true,
              enableControlFinishLoad: true,
              header: easyRefreshHeader,
              footer: easyRefreshFooter,
              onLoad: () async {
                BlocProvider.of<PostsBloc>(context)
                    .add(PostLoadMore(widget.postKey));
              },
              onRefresh: () async {
                BlocProvider.of<PostsBloc>(context)
                    .add(PostRefresh(widget.postKey));
              },
              emptyWidget: (filterData.isEmpty) ? const EmptyData() : null,
              slivers: filterData.map((p) => PostsItem(p)).toList(),
            );
          },
        )),
      ]),
    );
  }
}
