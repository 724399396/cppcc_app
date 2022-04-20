import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/models/meeting.dart';
import 'package:cppcc_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class MeetingActivitiesDetailsPage extends StatelessWidget {
  const MeetingActivitiesDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)?.settings.arguments as String;
    BlocProvider.of<MeetingBloc>(context).add(GetMeetingDetail(id));
    var themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "会议详情",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.appOrange,
        elevation: 0.0,
      ),
      backgroundColor: const Color(0xfff4f4f4),
      body: BlocBuilder<MeetingBloc, MeetingState>(
        builder: (context, state) {
          MeetingDetail? meeting = state.currentMetting;
          return meeting == null
              ? Container()
              : ListView(
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Text(meeting.title,
                          style: themeData.textTheme.titleLarge),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "会议时间: " +
                                  meeting.beginDate +
                                  " " +
                                  meeting.startTime.substring(0, 5) +
                                  "-" +
                                  meeting.endTime.substring(0, 5),
                              style: themeData.textTheme.bodyText2),
                          Text("会议地点: " + meeting.address,
                              style: themeData.textTheme.bodyText2),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("会议内容: ", style: themeData.textTheme.bodyText2),
                          meeting.content != ""
                              ? Html(
                                  data: meeting.content,
                                  tagsList: Html.tags
                                    ..addAll(["bird", "flutter"]),
                                )
                              : Container()
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("实时播报: ", style: themeData.textTheme.bodyText2),
                          BroadcastPage(meeting),
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
                            child: JoinUsersPage(meeting),
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
                            child: meeting.signQrcode != ""
                                ? Image.network(
                                    meeting.signQrcode.toString(),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}

// 播报
class BroadcastPage extends StatelessWidget {
  final MeetingDetail _meeting;
  const BroadcastPage(this._meeting, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// 参会人员
class JoinUsersPage extends StatelessWidget {
  final MeetingDetail _meeting;
  const JoinUsersPage(this._meeting, {Key? key}) : super(key: key);

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
          _meeting.userRecords.length ~/ 4,
          (start) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (add) {
              var us = _meeting.userRecords[4 * start + add];
              return GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(children: [
                    const Icon(Icons.person, color: Color(0xfffca555)),
                    Text(us.userIdDictText),
                  ]),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
