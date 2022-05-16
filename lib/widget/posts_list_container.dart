import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PostsListContainer extends StatelessWidget {
  final PostKey postKey;

  const PostsListContainer(this.postKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _easyRefreshController = EasyRefreshController();
    BlocProvider.of<PostsBloc>(context).add(PostFirstFetch(postKey));
    return SafeArea(
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
          var data = state.posts[postKey];
          return EasyRefresh.custom(
            controller: _easyRefreshController,
            enableControlFinishRefresh: true,
            enableControlFinishLoad: true,
            header: easyRefreshHeader,
            footer: easyRefreshFooter,
            onLoad: () async {
              BlocProvider.of<PostsBloc>(context).add(PostLoadMore(postKey));
            },
            onRefresh: () async {
              BlocProvider.of<PostsBloc>(context).add(PostRefresh(postKey));
            },
            emptyWidget: (data?.isEmpty ?? true) ? const EmptyData() : null,
            slivers: data?.map((p) => PostsItem(p)).toList() ?? [],
          );
        },
      ),
    );
    // ),
  }
}
