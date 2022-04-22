import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
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
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "详情",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xfff27f56),
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xfff4f4f4),
      body: Stack(
        alignment: Alignment.center,
        children: [
          BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              return EasyRefresh.custom(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      // 顶部栏
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Color(0xffffffff),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.maxFinite,
                              margin: const EdgeInsets.only(top: 10, bottom: 5),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Color(0xfff4f4f4)),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: double.maxFinite,
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    decoration: const BoxDecoration(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFc6c3bc),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 4),
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
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: _post.content != ""
                                  ? Html(
                                      data: _post.content,
                                      tagsList: Html.tags
                                        ..addAll(["bird", "flutter"]),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}