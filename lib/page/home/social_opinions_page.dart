import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/models/dict.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/posts_item.dart';

class SocialOpinionsPage extends StatefulWidget {
  const SocialOpinionsPage({Key? key}) : super(key: key);

  @override
  _SocialOpinionsPageState createState() => _SocialOpinionsPageState();
}

class _SocialOpinionsPageState extends State<SocialOpinionsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  List<Dict> _tabs = [];

  @override
  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    var dictMap =
        BlocProvider.of<AppSettingBloc>(context, listen: false).state.dictMap;
    var opinionTypes = dictMap["opinion_type"];
    _tabController = TabController(
        initialIndex: 1, length: opinionTypes?.length ?? 0, vsync: this);
    _tabs = opinionTypes ?? [];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<AppSettingBloc, AppSettingState>(
      listener: (context, state) {
        var opinionTypes = state.dictMap["opinion_type"];
        setState(() {
          _tabController = TabController(
              initialIndex: 0, length: opinionTypes!.length, vsync: this);
          _tabs = opinionTypes;
        });
      },
      child: Scaffold(
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
                      item.itemText,
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
            return MemberContentPage(codeType: item.itemValue);
          }).toList(),
        ),
      ),
    );
  }
}

// 列表信息
class MemberContentPage extends StatelessWidget {
  final _easyRefreshController = EasyRefreshController();
  final String codeType;
  MemberContentPage({Key? key, required this.codeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffffffff),
      child: BlocConsumer<PostsBloc, PostsState>(
        buildWhen: (previous, current) =>
            previous.learnings != current.learnings ||
            previous.status != current.status,
        listenWhen: (previous, current) =>
            previous.learnings != current.learnings ||
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
        builder: (context, state) => EasyRefresh.custom(
          controller: _easyRefreshController,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          header: ClassicalHeader(
            refreshText: '下拉刷新',
            refreshReadyText: '释放刷新',
            refreshingText: '加载中',
            refreshedText: '加载完成',
            refreshFailedText: '加载失败',
            noMoreText: '没有更多数据',
            infoText: '更新于 %T',
            textColor: Colors.black,
          ),
          footer: ClassicalFooter(
            loadText: '上拉加载更多',
            loadReadyText: '释放刷新',
            loadingText: '加载中',
            loadedText: '加载完成',
            loadFailedText: '加载失败',
            noMoreText: '没有更多数据',
            infoText: '更新于 %T',
            textColor: Colors.black,
          ),
          onLoad: () async {
            BlocProvider.of<PostsBloc>(context).add(HomePostLoadMore());
          },
          onRefresh: () async {
            BlocProvider.of<PostsBloc>(context).add(HomePostRefresh());
          },
          emptyWidget: (state.learnings
                      .where((item) => item.category == int.parse(codeType)))
                  .isEmpty
              ? const Center(child: Text('暂无数据'))
              : null,
          slivers: (state.learnings
                  .where((item) => item.category == int.parse(codeType)))
              .map((p) => PostsItem(p))
              .toList(),
        ),
      ),
      // ),
    );
  }
}
