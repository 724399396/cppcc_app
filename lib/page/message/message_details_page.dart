import 'package:flutter/material.dart';
import 'package:cppcc_app/dto/message/message_entity.dart';
import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class MessageDetailsPage extends StatefulWidget {
  const MessageDetailsPage({Key? key}) : super(key: key);

  @override
  _MessageDetailsPageState createState() => _MessageDetailsPageState();
}

class _MessageDetailsPageState extends State<MessageDetailsPage> {
  String? msgID = null;
  MessageRecords? message = null;
  @override
  Widget build(BuildContext context) {
    dynamic obj = ModalRoute.of(context)?.settings.arguments;
    if (obj != null) {
      msgID = obj["msgID"];
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("消息详情"),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(child: BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              state.listDatas
                  .where((item) => item.id == msgID)
                  .forEach((item) => message = item);

              return Container(
                width: double.infinity,
                height: double.maxFinite,
                padding: new EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  color: Color(0xffffffff),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xfff4f4f4)),
                        ),
                      ),
                      child: Text(message?.titile ?? "",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff333333),
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: message?.msgContent != null
                          ? Container(
                              child: Html(
                                data: message?.msgContent,
                                tagsList: Html.tags
                                  ..addAll(["bird", "flutter"]),
                              ),
                            )
                          : Container(),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(width: 1, color: Color(0xfff4f4f4)),
                        ),
                      ),
                      child: Text(message?.sendTime ?? "",
                          textAlign: TextAlign.right,
                          style: TextStyle(
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
