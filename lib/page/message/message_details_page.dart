import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:cppcc_app/models/message.dart';
import 'package:cppcc_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class MessageDetailsPage extends StatefulWidget {
  const MessageDetailsPage({Key? key}) : super(key: key);

  @override
  _MessageDetailsPageState createState() => _MessageDetailsPageState();
}

class _MessageDetailsPageState extends State<MessageDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Message message = ModalRoute.of(context)?.settings.arguments as Message;
    BlocProvider.of<MessageBloc>(context).add(MessageRead(message));
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("消息详情"),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  message.title,
                  style: themeData.textTheme.titleLarge,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Html(
                  data: message.msgContent,
                  tagsList: Html.tags..addAll(["bird", "flutter"]),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Text(message.sendTime,
                    textAlign: TextAlign.right,
                    style: themeData.textTheme.caption
                        ?.copyWith(color: AppColors.greyTextColor)),
              )
            ],
          ),
        ));
  }
}
