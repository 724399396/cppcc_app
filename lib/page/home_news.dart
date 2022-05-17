import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  State<HomeNews> createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  String _keyword = "";
  @override
  Widget build(BuildContext context) {
    var _easyRefreshController = EasyRefreshController();
    return SafeArea(
        child: Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          child: SizedBox(
            child: Image.asset(
              'assets/bg/bg_news.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          child: GeneralSearch(
            Colors.white,
            ((context, keyword) => {
                  setState(() {
                    _keyword = keyword;
                  })
                }),
            initValue: _keyword,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 80),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: AppColors.background,
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
              var data = (state.posts[const PostKey(PostType.news, null)] ?? [])
                  .where((element) => element.title.contains(_keyword));
              return EasyRefresh.custom(
                controller: _easyRefreshController,
                enableControlFinishRefresh: true,
                enableControlFinishLoad: true,
                header: easyRefreshHeader,
                footer: easyRefreshFooter,
                onLoad: () async {
                  BlocProvider.of<PostsBloc>(context)
                      .add(const PostLoadMore(PostKey(PostType.news, null)));
                },
                onRefresh: () async {
                  BlocProvider.of<PostsBloc>(context)
                      .add(const PostRefresh(PostKey(PostType.news, null)));
                },
                emptyWidget: data.isEmpty ? const EmptyData() : null,
                slivers: data.map((p) => PostsItem(p)).toList(),
              );
            },
          ),
        ),
      ],
    ));
  }
}
