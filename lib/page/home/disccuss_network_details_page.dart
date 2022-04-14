import 'package:cppcc_app/bloc/discuss_network_bloc.dart';
import 'package:cppcc_app/models/discuss_network.dart';
import 'package:cppcc_app/widget/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscussNetworkDetailsPage extends StatelessWidget {
  const DiscussNetworkDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DiscussNetwork bean = ModalRoute.of(context)?.settings.arguments as DiscussNetwork;
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
          BlocBuilder<DiscussNetworkBloc, DiscussNetworkState>(
            builder: (context, state) {
              return EasyRefresh.custom(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      // 顶部栏
                      Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
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
                                    child: Text(bean.title,
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
                                            color: bean.status == 1
                                                ? const Color(0xFFc6c3bc)
                                                : const Color(0xff3c6dea),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 4),
                                          child: Text(
                                            bean.statusDictText,
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
                                        Text(bean.createBy,
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
                              child: bean.description != ""
                                  ? Html(
                                    data: bean.description,
                                    tagsList: Html.tags
                                      ..addAll(["bird", "flutter"]),
                                  )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
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
                                    child: const Text("参与人：",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff333333),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: bean.description != ""
                                  ? const Expanded(
                                      child: Text("内容"),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: const BoxDecoration(
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
                                    child: const Text("观点：",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color(0xff333333),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: bean.description != ""
                                  ? const Expanded(
                                      child: Text("内容"),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ChatInput(placeholder: "请输入内容！"),
                      ),
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
