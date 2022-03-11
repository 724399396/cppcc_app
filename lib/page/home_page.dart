import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    var moduleIconWidth = deviceSize.width / 8;
    var _easyRefreshController = EasyRefreshController();
    return SafeArea(
        child: Stack(alignment: Alignment.center, children: [
      Positioned.fill(
        child: Image.asset(
          'assets/bg/bg_home.png',
          fit: BoxFit.fitWidth,
          alignment: Alignment.topLeft,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '官渡区政协委员履职平台',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    'assets/icons/ic_logo.png',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(flex: 4, child: GeneralSearch()),
              const SizedBox(width: 8),
              Expanded(
                  flex: 1,
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                        backgroundColor: const Color(0x88FFFFFF),
                        child: Image.asset(
                          'assets/icons/ic_saom.png',
                          width: 24,
                        ),
                      ))),
              const SizedBox(width: 8),
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
            margin: const EdgeInsets.only(top: 8),
            child: Column(
                children: List.generate(
                    homeTabs.length ~/ 4,
                    (start) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(4, (add) {
                            var currentTab = homeTabs[4 * start + add];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Column(children: [
                                Image.asset(
                                  currentTab.image,
                                  width: moduleIconWidth,
                                ),
                                Text(currentTab.text),
                              ]),
                            );
                          }),
                        ))),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8)),
                      width: 6,
                      height: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '最新动态',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ],
            ),
          ),
          // 文件公告和资讯
          Expanded(
            child: BlocConsumer<PostsBloc, PostsState>(
              buildWhen: (previous, current) =>
                  previous.news != current.news ||
                  previous.fileAnnments != current.fileAnnments ||
                  previous.status != current.status,
              listenWhen: (previous, current) =>
                  previous.news != current.news ||
                  previous.fileAnnments != current.fileAnnments ||
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
                emptyWidget: (state.news + state.fileAnnments).isEmpty
                    ? const Center(child: Text('暂无数据'))
                    : null,
                slivers: (state.news + state.fileAnnments)
                    .map((p) => PostsItem(p))
                    .toList(),
              ),
            ),
            // ),
          ),
        ],
      ),
    ]));
  }
}
