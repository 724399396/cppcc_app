import 'package:cppcc_app/bloc/news_bloc.dart';
import 'package:cppcc_app/dto/news/news_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsDetailsPage extends StatefulWidget {
  const NewsDetailsPage({Key? key}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage> {
  String? id;
  NewsRecords? news;
  @override
  Widget build(BuildContext context) {
    dynamic obj = ModalRoute.of(context)?.settings.arguments;
    if (obj != null) {
      id = obj["id"];
    }
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
        backgroundColor: Color(0xfff27f56),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xfff4f4f4),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              state.listDatas
                  .where((item) => item.id == id)
                  .forEach((item) => news = item);

              return Container(
                width: double.infinity,
                height: double.maxFinite,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.only(bottom: 15),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xfff4f4f4)),
                        ),
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(news?.title ?? "",
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xff333333),
                                )),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(news?.createTime ?? "",
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: Color(0xff999999),
                                      )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(news?.author ?? "",
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
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: news?.content != null
                          ? Expanded(
                              child: Html(
                                data: news?.content,
                                tagsList: Html.tags
                                  ..addAll(["bird", "flutter"]),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(top: 10),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1, color: Color(0xfff4f4f4)),
                        ),
                      ),
                      child: Text(news?.createTime ?? "",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff999999),
                          )),
                    )
                  ],
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
