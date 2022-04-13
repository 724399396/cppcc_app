import 'package:cppcc_app/bloc/opinion_bloc.dart';
import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget buildTabItem(title, image, path, unreadCount, context) {
    var deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(path);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(children: [
              Image.asset(
                image,
                width: deviceSize.width / 8,
              ),
              Text(title),
            ]),
            unreadCount > 0
                ? Positioned(
                    top: 0,
                    right: -12,
                    child: Container(
                      width: 18,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFfa7c2f),
                      ),
                      child: Text(unreadCount.toString()),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTabItem('履职档案', 'assets/icons/ic_lvzhidangan.png',
                      Routes.performanceFilePage, 0, context),
                  BlocBuilder<OpinionBloc, OpinionState>(
                      builder: (context, state) => buildTabItem(
                          '社情民意',
                          'assets/icons/ic_sheqingmyi.png',
                          Routes.socialOpinionsPage,
                          state.unreadCount,
                          context)),
                  buildTabItem('提案管理', 'assets/icons/ic_tianbanli.png',
                      Routes.proposalManagePage, 0, context)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTabItem('会议活动', 'assets/icons/ic_huiyihuod.png',
                      Routes.meetingActivitiesPage, 0, context),
                  buildTabItem('通知公告', 'assets/icons/ic_wenjiangonggao.png',
                      Routes.noticePage, 0, context),
                  buildTabItem('网络议政', 'assets/icons/ic_wangluoyiz.png',
                      Routes.networkPoliticalPage, 0, context),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildTabItem('委员学习', 'assets/icons/ic_weiyuanxuexi.png',
                      Routes.memberStudyPage, 0, context),
                  buildTabItem('领导信箱', 'assets/icons/ic_lingdaoyoux.png',
                      Routes.leaderMailboxPage, 0, context),
                  buildTabItem('官渡文史', 'assets/icons/ic_guanduwenshi.png',
                      Routes.gdHistoryPage, 0, context),
                ],
              ),
            ]),
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
                header: easyRefreshHeader,
                footer: easyRefreshFooter,
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
