import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/models/meeting.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:timelines/timelines.dart';
import 'package:collection/collection.dart';

class MeetingActivitiesDetailsPage extends StatelessWidget {
  const MeetingActivitiesDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context)?.settings.arguments as String;
    BlocProvider.of<MeetingBloc>(context).add(GetMeetingDetail(id));
    var themeData = Theme.of(context);
    return BlocBuilder<MeetingBloc, MeetingState>(builder: (context, state) {
      MeetingDetail? meeting = state.currentMetting;
      MeetingActiveRecord? currentUserJoinState = meeting?.userRecords
          .firstWhereOrNull((element) =>
              element.userId ==
              BlocProvider.of<UserBloc>(context).state.userInfo?.userId);
      return Scaffold(
        appBar: AppBar(
          title: const Text("会议详情"),
        ),
        floatingActionButton: (currentUserJoinState?.status == 1 &&
                meeting != null)
            ? FloatingActionButton.extended(
                backgroundColor: AppColors.appOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                extendedPadding: const EdgeInsets.symmetric(horizontal: 4),
                label: state.submitStatus == FormStatus.submissionInProgress
                    ? const SizedBox(
                        width: 32,
                        height: 32,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text("我要请假"),
                onPressed: () {
                  if (state.submitStatus == FormStatus.submissionInProgress) {
                    return;
                  }
                  BlocProvider.of<MeetingBloc>(context).add(
                    ApplyLeaveMeeting(meeting.id, currentUserJoinState!.userId,
                        () {
                      showToast('请假成功!');
                    }),
                  );
                },
              )
            : Container(),
        body: meeting == null
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
                    height: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("实时播报: ", style: themeData.textTheme.bodyText2),
                        Expanded(child: BroadcastPage(meeting)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("参与人: ", style: themeData.textTheme.bodyText2),
                        Expanded(child: JoinUsersPage(meeting)),
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
                        Text("签到二维码: ", style: themeData.textTheme.bodyText2),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                              currentUserJoinState?.status == 1
                                  ? "未签到"
                                  : (currentUserJoinState?.status == 2
                                      ? "已签到"
                                      : ""),
                              style: themeData.textTheme.bodyText2),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: meeting.signQrcode != ""
                              ? CachedNetworkImage(
                                  width: 200,
                                  imageUrl: meeting.signQrcode.toString())
                              : Container(),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '请出示二维码进行签到',
                            style: themeData.textTheme.bodyLarge
                                ?.copyWith(color: AppColors.greyTextColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}

// 播报
class BroadcastPage extends StatelessWidget {
  final MeetingDetail _meeting;
  const BroadcastPage(this._meeting, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      theme: TimelineThemeData(
          indicatorTheme:
              const IndicatorThemeData(color: AppColors.greyTextColor),
          connectorTheme: const ConnectorThemeData(
              color: AppColors.greyTextColor, thickness: 1)),
      builder: TimelineTileBuilder.fromStyle(
        nodePositionBuilder: (context, index) => 0,
        indicatorPositionBuilder: (context, index) => 0,
        indicatorStyle: IndicatorStyle.outlined,
        contentsAlign: ContentsAlign.basic,
        contentsBuilder: (context, index) {
          Broadcast broadcast = _meeting.broadcasts[index];
          return Container(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(broadcast.createTime,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: AppColors.greyTextColor)),
                Text(broadcast.title,
                    style: Theme.of(context).textTheme.bodyText1),
                broadcast.content != ''
                    ? Html(
                        data: broadcast.content,
                        tagsList: Html.tags..addAll(["bird", "flutter"]),
                      )
                    : Container(),
              ],
            ),
          );
        },
        itemCount: _meeting.broadcasts.length,
      ),
    );
  }
}

// 参会人员
class JoinUsersPage extends StatelessWidget {
  final MeetingDetail _meeting;
  const JoinUsersPage(this._meeting, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GridView.count(
        crossAxisCount: 4,
        children: List.generate(_meeting.userRecords.length, (index) {
          var us = _meeting.userRecords[index];
          return GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: 24,
              child: Row(children: [
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Image.asset(
                        us.status == 2
                            ? 'assets/icons/ic_online.png'
                            : 'assets/icons/ic_offline.png',
                        width: 28,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Image.asset(
                        us.read
                            ? 'assets/icons/ic_yiyuedu.png'
                            : 'assets/icons/ic_weiyuedu.png',
                        width: 14,
                      ),
                    ),
                  ],
                ),
                Text(us.userIdDictText),
              ]),
            ),
          );
        }),
      ),
    );
  }
}
