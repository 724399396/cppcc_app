import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:cppcc_app/bloc/news_topic_bloc.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  _HomeNewsState createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  @override
  Widget build(BuildContext context) {
    var _easyRefreshController = EasyRefreshController();
    return SafeArea(
        child: Stack(alignment: Alignment.center, children: [
      Positioned.fill(
        child: SizedBox(
          height: 1,
          child: Image.asset(
            'assets/bg/bg_news.png',
            fit: BoxFit.fitWidth,
            alignment: Alignment.topLeft,
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            // TODO
            child: GeneralSearch(Colors.white, ((context, keyword) => {})),
          ),
          SizedBox(
              height: 48,
              child: BlocBuilder<NewsTopicBloc, NewsTopicState>(
                builder: (context, state) {
                  return EasyRefresh.custom(
                    scrollDirection: Axis.horizontal,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return TextButton(
                              onPressed: () {
                                // TODO
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 0.5, color: Color(0xffffffff)),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      state.listDatas[index].itemText,
                                      style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xffffffff)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: state.listDatas.length,
                        ),
                      ),
                    ],
                  );
                },
              )),
          Expanded(
            child: BlocConsumer<PostsBloc, PostsState>(
              buildWhen: (previous, current) =>
                  previous.posts != current.posts ||
                  previous.status != current.status,
              listenWhen: (previous, current) =>
                  previous.posts != current.posts ||
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
                var data = state.posts[const PostKey(PostType.news, null)];
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
                  emptyWidget: (data?.isEmpty ?? true)
                      ? const Center(child: Text('暂无数据'))
                      : null,
                  slivers: data?.map((p) => PostsItem(p)).toList() ?? [],
                );
              },
            ),
            // ),
          ),
        ],
      ),
    ]));
  }
}
