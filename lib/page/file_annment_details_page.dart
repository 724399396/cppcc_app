import 'package:cppcc_app/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:intl/intl.dart';

class FileAnnmentDetailsPage extends StatelessWidget {
  const FileAnnmentDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostsBloc>(context)
        .add(PostReaded(ModalRoute.of(context)?.settings.arguments as Posts));
    return Scaffold(
      appBar: AppBar(
        title: const Text("详情"),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(
        builder: (context, state) {
          Posts? _post = state.currentPost;
          return _post == null ? Container() : ListView(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text(
                            _post.author ?? '',
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Color(0xff999999),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              DateFormat('yyyy-MM-dd HH:mm')
                                  .format(_post.createTime),
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Color(0xff999999),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(_post.hits.toString() + '阅读',
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
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: _post.content != ""
                    ? Html(
                        data: _post.content,
                        tagsList: Html.tags..addAll(["bird", "flutter"]),
                      )
                    : Container(),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '已读：${_post.userReadRecords.length}',
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      child: GridView.count(
                        crossAxisCount: 4,
                        children:
                            List.generate(_post.userReadRecords.length, (index) {
                          var us = _post.userReadRecords[index];
                          return GestureDetector(
                            onTap: () {},
                            child: SizedBox(
                              height: 24,
                              child: Row(children: [
                                Stack(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Image.asset(
                                        'assets/icons/ic_normal.png',
                                        width: 28,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(us.userRealname),
                              ]),
                            ),
                          );
                        }),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
