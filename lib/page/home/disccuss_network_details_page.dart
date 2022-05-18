import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/bloc/discuss_network_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/dto/discuss_network_request.dart';
import 'package:cppcc_app/models/discuss_network.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class DiscussNetworkDetailsPage extends StatelessWidget {
  const DiscussNetworkDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boldTextStyle = const TextStyle(fontWeight: FontWeight.bold);
    BlocProvider.of<DiscussNetworkBloc>(context).add(GoDiscussNetworkDetail(
        ModalRoute.of(context)?.settings.arguments as DiscussNetwork));
    return Scaffold(
        appBar: AppBar(
          title: const Text("详情"),
        ),
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<DiscussNetworkBloc, DiscussNetworkState>(
          builder: (context, state) {
            final DiscussNetwork? bean = state.currentDiscuss;
            return bean == null
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        color: Colors.white,
                        child: Text(bean.title,
                            style: const TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('开始时间:', style: boldTextStyle),
                                const SizedBox(width: 4),
                                Text(bean.beginDate, style: boldTextStyle)
                              ],
                            ),
                            Row(
                              children: [
                                Text('结束时间:', style: boldTextStyle),
                                const SizedBox(width: 2),
                                Text(bean.endDate, style: boldTextStyle)
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text('说明:', style: boldTextStyle),
                            Container(
                              child: bean.description != ""
                                  ? Html(
                                      data: bean.description,
                                      tagsList: Html.tags
                                        ..addAll(["bird", "flutter"]),
                                    )
                                  : Container(),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    Routes.discussNetworkFilePage,
                                    arguments: bean);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xff3a6cea)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                child: const Text(
                                  '文件资料',
                                  style: TextStyle(
                                      fontSize: 16, color: Color(0xff3a6cea)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("参与人："),
                            SizedBox(
                              height: 100,
                              child: GridView.count(
                                childAspectRatio: 2,
                                crossAxisCount: 4,
                                children: List.generate(bean.userRecords.length,
                                    (index) {
                                  var us = bean.userRecords[index];
                                  return Container(
                                    constraints:
                                        const BoxConstraints(maxHeight: 34),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Image.asset(
                                            'assets/icons/ic_normal.png',
                                            width: 28,
                                            height: 28,
                                          ),
                                        ),
                                        Text(us.userRealname),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("观点："),
                              const SizedBox(height: 4),
                              Expanded(
                                child: ListView(
                                  children: bean.discussMessages.map((msg) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      constraints:
                                          const BoxConstraints(minHeight: 96),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 16,
                                              backgroundImage: msg.ownerAvatar ==
                                                      null
                                                  ? Image.asset(
                                                          'assets/icons/ic_wode_selected.png')
                                                      .image
                                                  : CachedNetworkImageProvider(
                                                      msg.ownerAvatar!),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(msg.ownerName),
                                                  Container(
                                                    child: msg.message != ""
                                                        ? Html(
                                                            data: msg.message,
                                                            tagsList: Html.tags
                                                              ..addAll([
                                                                "bird",
                                                                "flutter"
                                                              ]),
                                                          )
                                                        : Container(),
                                                  ),
                                                  Text(
                                                    msg.createTime,
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .greyTextColor,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    if (!msg.thumbUpStatus) {
                                                      BlocProvider.of<
                                                                  DiscussNetworkBloc>(
                                                              context)
                                                          .add(
                                                        DicusssNetworkMsgLike(
                                                            msg.id, 2, () {
                                                          showToast('点赞成功');
                                                        }),
                                                      );
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        'assets/icons/ic_dz2.png',
                                                        width: 16,
                                                        color: msg.thumbUpStatus
                                                            ? AppColors.primary
                                                            : AppColors
                                                                .greyTextColor,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        msg.thumbUpCount
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .greyTextColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ]),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ChatInput(bean),
                    ],
                  );
          },
        ));
  }
}

class ChatInput extends StatelessWidget {
  final DiscussNetwork bean;
  const ChatInput(this.bean, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: TextField(
                  controller: textController,
                  onSubmitted: (value) {
                    BlocProvider.of<DiscussNetworkBloc>(context).add(
                        DicusssNetworkMsgSend(
                            DiscussMessageSendRequest(
                                discussNetworkId: bean.id,
                                userId: BlocProvider.of<UserBloc>(context)
                                    .state
                                    .userInfo!
                                    .userId,
                                message: value), () {
                      showToast('发表成功');
                      textController.clear();
                    }));
                  },
                  decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                      hintText: "发表您的观点",
                      hintStyle: TextStyle(color: Colors.grey))),
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (!bean.thumbUpStatus) {
                BlocProvider.of<DiscussNetworkBloc>(context)
                    .add(DicusssNetworkMsgLike(bean.id, 1, () {
                  showToast('点赞成功');
                }));
              }
            },
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/ic_dz.png',
                  width: 24,
                  color: bean.thumbUpStatus
                      ? AppColors.primary
                      : AppColors.greyTextColor,
                ),
                const SizedBox(width: 4),
                Text(
                  bean.thumbUpCount.toString(),
                  style: const TextStyle(color: AppColors.greyTextColor),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Row(
            children: [
              Image.asset('assets/icons/ic_pl.png', width: 24),
              const SizedBox(width: 4),
              Text(
                bean.commentCount.toString(),
                style: const TextStyle(color: AppColors.greyTextColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
