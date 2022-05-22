import 'package:cppcc_app/bloc/discuss_network_bloc.dart';
import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/bloc/opinion_bloc.dart';
import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/bloc/proposal_bloc.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget buildTabItem(title, image, path, unreadCount, context,
      {routeArguments}) {
    var deviceSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(path, arguments: routeArguments);
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
    return SafeArea(
      top: false,
      child: Stack(
        children: [
             Container(
              color: AppColors.primary,
              height: 36,
            ),
          Positioned.fill(
            top: 36,
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
                padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
                child: Text(
                  '官渡区政协委员履职平台',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
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
                  Expanded(
                      flex: 4,
                      child: GeneralSearch(Colors.white, (context, keyword) {
                        Navigator.of(context)
                            .pushNamed(Routes.searchPage, arguments: keyword);
                      })),
                  const SizedBox(width: 8),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.scanQRCode);
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: CircleAvatar(
                              backgroundColor: const Color(0x88FFFFFF),
                              child: Image.asset(
                                'assets/icons/ic_saom.png',
                                width: 24,
                              ),
                            )),
                      )),
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
                      BlocBuilder<ProposalBloc, ProposalState>(
                          builder: (contxst, state) => buildTabItem(
                              '提案管理',
                              'assets/icons/ic_tianbanli.png',
                              Routes.proposalManagePage,
                              state.unreadCount,
                              context)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<MeetingBloc, MeetingState>(
                        builder: (context, state) {
                          return buildTabItem(
                              '会议活动',
                              'assets/icons/ic_huiyihuod.png',
                              Routes.meetingActivitiesPage,
                              state.unreadCount,
                              context);
                        },
                      ),
                      BlocBuilder<PostsBloc, PostsState>(
                        builder: (context, state) {
                          return buildTabItem(
                              '文件公告',
                              'assets/icons/ic_wenjiangonggao.png',
                              Routes.fileAnnmentPage,
                              state.unreadCount[PostType.fileAnnment] ?? 0,
                              context);
                        },
                      ),
                      BlocBuilder<DiscussNetworkBloc, DiscussNetworkState>(
                        builder: (context, state) {
                          return buildTabItem(
                              '网络议政',
                              'assets/icons/ic_wangluoyiz.png',
                              Routes.discussNetworkPage,
                              state.unreadCount,
                              context);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<PostsBloc, PostsState>(
                        builder: (context, state) {
                          return buildTabItem(
                              '委员学习',
                              'assets/icons/ic_weiyuanxuexi.png',
                              Routes.committeStudyPage,
                              state.unreadCount[PostType.learning] ?? 0,
                              context);
                        },
                      ),
                      BlocBuilder<MailboxBloc, MailboxState>(
                        builder: (context, state) {
                          return buildTabItem(
                              '领导信箱',
                              'assets/icons/ic_lingdaoyoux.png',
                              Routes.leaderMailboxPage,
                              state.unreadCount,
                              context);
                        },
                      ),
                      BlocBuilder<PostsBloc, PostsState>(
                        builder: (context, state) {
                          return buildTabItem(
                            '官渡文史',
                            'assets/icons/ic_guanduwenshi.png',
                            Routes.guanduHistoryListPage,
                            state.unreadCount[PostType.guanduHistory] ?? 0,
                            context,
                          );
                        },
                      ),
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
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocEasyFrefresh<PostsBloc, PostsState, Posts>(
                      (state) =>
                          (state.posts[const PostKey(PostType.news, null)] ??
                              []) +
                          (state.posts[
                                  const PostKey(PostType.fileAnnment, null)] ??
                              []), () async {
                    BlocProvider.of<PostsBloc>(context)
                        .add(const PostLoadMore(PostKey(PostType.news, null)));
                    BlocProvider.of<PostsBloc>(context).add(const PostLoadMore(
                        PostKey(PostType.fileAnnment, null)));
                  }, () async {
                    BlocProvider.of<PostsBloc>(context)
                        .add(const PostRefresh(PostKey(PostType.news, null)));
                    BlocProvider.of<PostsBloc>(context).add(
                        const PostRefresh(PostKey(PostType.fileAnnment, null)));
                  }, (p) => PostsItem(p)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
