import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsListContainer extends StatelessWidget {
  final PostKey postKey;

  const PostsListContainer(this.postKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostsBloc>(context).add(PostFirstFetch(postKey));
    return SafeArea(
      child: BlocEasyFrefresh<PostsBloc, PostsState, Posts>(
          (state) => state.posts[postKey] ?? [], () async {
        BlocProvider.of<PostsBloc>(context).add(PostLoadMore(postKey));
      }, () async {
        BlocProvider.of<PostsBloc>(context).add(PostRefresh(postKey));
      }, (p) => PostsItem(p)),
    );
    // ),
  }
}
