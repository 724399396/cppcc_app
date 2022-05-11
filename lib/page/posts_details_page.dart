import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:cppcc_app/bloc/posts_bloc.dart';

class PostsDetailPage extends StatelessWidget {
  const PostsDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Posts _post = ModalRoute.of(context)?.settings.arguments as Posts;
    BlocProvider.of<PostsBloc>(context).add(PostReaded(_post));
    return Scaffold(
      appBar: AppBar(
        title: const Text("详情"),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Text(_post.title,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xff333333),
                )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFc6c3bc),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: Text(
                    _post.postType.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(_post.createBy,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Color(0xff999999),
                    )),
              ],
            ),
          ),
          // 顶部栏
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: _post.content != ""
                ? Html(
                    data: _post.content,
                    tagsList: Html.tags..addAll(["bird", "flutter"]),
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
