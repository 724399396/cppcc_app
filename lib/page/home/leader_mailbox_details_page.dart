import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/models/mail.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/widget/url_file_opener.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class LeaderMailboxDetailsPage extends StatelessWidget {
  const LeaderMailboxDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MailboxBloc>(context).add(
        GoMailDetail((ModalRoute.of(context)?.settings.arguments as Mail).id));
    var divide = Container(
      color: AppColors.greyTextColor,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 0.2,
      width: double.infinity,
    );
    const contentStyle = TextStyle(fontSize: 14);
    return Scaffold(
        appBar: AppBar(
          title: const Text("详情"),
        ),
        body: BlocBuilder<MailboxBloc, MailboxState>(
          builder: (context, state) {
            Mail? _bean = state.currentMail;
            return _bean == null
                ? Container()
                : Container(
                    padding: const EdgeInsets.all(12),
                    child: ListView(
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 12),
                            Container(
                                width: 4,
                                height: 18,
                                margin: const EdgeInsets.only(right: 8),
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(3)),
                                  color: Color(0xFFfa7c2f),
                                )),
                            const Text('来信情况', style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text('信件标题:', style: contentStyle),
                                  const SizedBox(width: 8),
                                  Text(_bean.title, style: contentStyle),
                                ],
                              ),
                              divide,
                              Row(
                                children: [
                                  const Text('来信时间:', style: contentStyle),
                                  const SizedBox(width: 8),
                                  Text(_bean.createTime,
                                      style: contentStyle.copyWith(
                                          color: AppColors.greyTextColor)),
                                ],
                              ),
                              divide,
                              Row(
                                children: const [
                                  Text('来信内容:', style: contentStyle),
                                  SizedBox(width: 4),
                                ],
                              ),
                              _bean.content != ""
                                  ? Html(
                                      data: _bean.content,
                                      tagsList: Html.tags
                                        ..addAll(["bird", "flutter"]),
                                    )
                                  : Container(),
                              ...(_bean.appendix
                                      ?.map((url) => UrlFileOpener(url)) ??
                                  [])
                            ],
                          ),
                        ),
                        ...(_bean.replyMessage.isNotEmpty
                            ? [
                                // 受理情况
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const SizedBox(width: 12),
                                    Container(
                                        width: 4,
                                        height: 18,
                                        margin: const EdgeInsets.only(right: 8),
                                        alignment: Alignment.center,
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(3)),
                                          color: Color(0xFFfa7c2f),
                                        )),
                                    const Text('受理情况',
                                        style: TextStyle(fontSize: 16)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 12),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text('受理单位:',
                                              style: contentStyle),
                                          const SizedBox(width: 8),
                                          Text(_bean.handleWorkunit,
                                              style: contentStyle),
                                        ],
                                      ),
                                      divide,
                                      Row(
                                        children: [
                                          const Text('受理时间:',
                                              style: contentStyle),
                                          const SizedBox(width: 8),
                                          Text(
                                              _bean.handleTime != null
                                                  ? DateFormat(
                                                          'yyyy-MM-dd HH:mm')
                                                      .format(_bean.handleTime!)
                                                  : '',
                                              style: contentStyle.copyWith(
                                                  color:
                                                      AppColors.greyTextColor)),
                                        ],
                                      ),
                                      divide,
                                      Row(
                                        children: const [
                                          Text('回复内容:', style: contentStyle),
                                          SizedBox(width: 4),
                                        ],
                                      ),
                                      _bean.content != ""
                                          ? Html(
                                              data: _bean.replyMessage,
                                              tagsList: Html.tags
                                                ..addAll(["bird", "flutter"]),
                                            )
                                          : Container()
                                    ],
                                  ),
                                )
                              ]
                            : [])
                      ],
                    ),
                  );
          },
        ));
  }
}
