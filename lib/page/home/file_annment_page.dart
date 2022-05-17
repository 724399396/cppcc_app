import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:timeago/timeago.dart' as timeago;

class FileAnnmentPage extends StatefulWidget {
  const FileAnnmentPage({Key? key}) : super(key: key);

  @override
  State<FileAnnmentPage> createState() => _FileAnnmentPageState();
}

class _FileAnnmentPageState extends State<FileAnnmentPage> {
  String _searchKeyWord = "";

  @override
  Widget build(BuildContext context) {
    var postKey = const PostKey(PostType.fileAnnment, null);
    var _easyRefreshController = EasyRefreshController();
    BlocProvider.of<PostsBloc>(context).add(PostFirstFetch(postKey));
    return Scaffold(
      appBar: AppBar(title: const Text('文件公告')),
      body: Container(
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
              var data = state.posts[postKey] ?? [];
              var filterData = (_searchKeyWord.isEmpty
                  ? data
                  : data
                      .where((d) => d.title.contains(_searchKeyWord))
                      .toList());
              return EasyRefresh.custom(
                controller: _easyRefreshController,
                enableControlFinishRefresh: true,
                enableControlFinishLoad: true,
                header: easyRefreshHeader,
                footer: easyRefreshFooter,
                onLoad: () async {
                  BlocProvider.of<PostsBloc>(context)
                      .add(PostLoadMore(postKey));
                },
                onRefresh: () async {
                  BlocProvider.of<PostsBloc>(context).add(PostRefresh(postKey));
                },
                emptyWidget: (filterData.isEmpty) ? const EmptyData() : null,
                slivers: filterData.map((p) => FileAnnmentItem(p)).toList(),
              );
            },
          )),
        ]),
      ),
    );
    // ),
  }
}

class FileAnnmentItem extends StatelessWidget {
  final Posts _post;
  const FileAnnmentItem(this._post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.fileAnnmentDetailsPage, arguments: _post);
      },
      child: Container(
        height: 120,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  _post.read
                      ? 'assets/icons/ic_gongg_grey.png'
                      : 'assets/icons/ic_gongg.png',
                  height: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFc6c3bc),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Text(
                    _post.categoryDictText != null
                        ? _post.categoryDictText!
                        : _post.postType.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  timeago.format(_post.createTime, locale: 'zh'),
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.greyTextColor),
                ),
                Expanded(child: Container()),
                Image.asset('assets/icons/ic_zhiding.png', height: 12),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
