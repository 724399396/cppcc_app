import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../widget/message_list_item.dart';
import 'package:cppcc_app/utils/routes.dart';

import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cppcc_app/bloc/news_topic_bloc.dart';

class HomeNews extends StatefulWidget {
  const HomeNews({Key? key}) : super(key: key);

  @override
  _HomeNewsState createState() => _HomeNewsState();
}

class _HomeNewsState extends State<HomeNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "资讯",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff27f56),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xfff4f4f4),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              color: Color(0xff),
              height: 58,
              child: BlocBuilder<NewsTopicBloc, NewsTopicState>(
                builder: (context, state) {
                  print(
                      "====listDatas====" + state.listDatas.length.toString());
                  return EasyRefresh.custom(
                    scrollDirection: Axis.horizontal,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return FlatButton(
                              onPressed: () {
                                print("object");
                              },
                              padding: EdgeInsets.all(5.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xffffffff)),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      state.listDatas[index].itemText,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff333333)),
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
          Container(
            margin: EdgeInsets.only(top: 58),
            child: Text("data"),
          )
        ],
      ),
    );
  }
}
