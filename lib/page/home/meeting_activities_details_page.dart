import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/dto/meeting_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_html/flutter_html.dart';

class MeetingActivitiesDetailsPage extends StatefulWidget {
  const MeetingActivitiesDetailsPage({Key? key}) : super(key: key);

  @override
  _MeetingActivitiesDetailsPageState createState() =>
      _MeetingActivitiesDetailsPageState();
}

class _MeetingActivitiesDetailsPageState
    extends State<MeetingActivitiesDetailsPage> {
  String? id;

  late MeetingResponse _bean;
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
          Container(child: BlocBuilder<MeetingBloc, MeetingState>(
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
                                      child: Text(_bean.title!,
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
                                              color: _bean.status == 1
                                                  ? const Color(0xFFc6c3bc)
                                                  : const Color(0xFF75e287),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 4),
                                            child: Text(
                                              _bean.statusDictText!,
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
                                          Text(_bean.createBy!,
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
                              padding: const EdgeInsets.only(left: 10),
                              width: double.maxFinite,
                              decoration: const BoxDecoration(),
                              child: Text(
                                  "时间:" +
                                      _bean.beginDate! +
                                      " " +
                                      _bean.startTime! +
                                      "-" +
                                      _bean.endTime!,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff333333),
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 10),
                              width: double.maxFinite,
                              decoration: const BoxDecoration(),
                              child: Text("地点:" + _bean.address!,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff333333),
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: _bean.content! != ""
                                  ? Container(
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
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              decoration: const BoxDecoration(),
                              child: const Text("实时播报：",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff333333),
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: BroadcastPage(_bean),
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
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              decoration: const BoxDecoration(),
                              child: const Text("参与人：",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff333333),
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: JoinUsersPage(_bean),
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
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 10),
                              decoration: const BoxDecoration(),
                              child: const Text("签到二维码：",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(0xff333333),
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: _bean.signQrcode != ""
                                  ? Expanded(
                                      child: Image.network(
                                          _bean.signQrcode.toString()),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
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

// 播报
// ignore: must_be_immutable
class BroadcastPage extends StatelessWidget {
  MeetingResponse _bean;
  BroadcastPage(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: List.generate(
          _bean.userRecords!.length ~/ 4,
          (start) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (add) {
              var us = _bean.userRecords![4 * start + add];
              return Container(
                  child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(children: [
                    const Icon(Icons.person, color: Color(0xfffca555)),
                    Text(us.userIdDictText!),
                  ]),
                ),
              ));
            }),
          ),
        ),
      ),
    );
  }
}

// 参会人员
// ignore: must_be_immutable
class JoinUsersPage extends StatelessWidget {
  MeetingResponse _bean;
  JoinUsersPage(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: List.generate(
          _bean.userRecords!.length ~/ 4,
          (start) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (add) {
              var us = _bean.userRecords![4 * start + add];
              return Container(
                  child: GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(children: [
                    const Icon(Icons.person, color: Color(0xfffca555)),
                    Text(us.userIdDictText!),
                  ]),
                ),
              ));
            }),
          ),
        ),
      ),
    );
  }
}
