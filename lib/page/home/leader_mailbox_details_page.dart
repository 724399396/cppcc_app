import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/dto/mailbox_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';

class LeaderMailboxDetailsPage extends StatefulWidget {
  const LeaderMailboxDetailsPage({Key? key}) : super(key: key);

  @override
  _LeaderMailboxDetailsPageState createState() =>
      _LeaderMailboxDetailsPageState();
}

class _LeaderMailboxDetailsPageState extends State<LeaderMailboxDetailsPage> {
  String? id;

  late MailboxResponse _bean;
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
        backgroundColor: const Color(0xfff27f56),
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xfff4f4f4),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(child: BlocBuilder<MailboxBloc, MailboxState>(
            builder: (context, state) {
              state.listDatas
                  .where((item) => item.id == id)
                  .forEach((item) => _bean = item);

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
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.maxFinite,
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      decoration: const BoxDecoration(),
                                      child: Text(_bean.title,
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
                                              _bean.typeDictText!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.white),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(_bean.userIdDictText!,
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
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: _bean.content != ""
                                  ? Expanded(
                                      child: Html(
                                        data: _bean.content,
                                        tagsList: Html.tags
                                          ..addAll(["bird", "flutter"]),
                                      ),
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
          ))
        ],
      ),
    );
  }
}
