import 'package:cppcc_app/models/posts.dart';
import 'package:flutter/material.dart';

class PostsItem extends StatelessWidget {
  final Posts _post;
  const PostsItem(this._post, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Text(_post.title),
    );
  }
}
