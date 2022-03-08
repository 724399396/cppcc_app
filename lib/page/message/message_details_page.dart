import 'package:cppcc_app/dto/message/message_entity.dart';
import 'package:flutter/material.dart';
import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    print("===============" + msgID.toString());

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: Text(
          "消息详情",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff27f56),
        elevation: 0.0,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(child: BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              print("====listDatas====" + state.listDatas.length.toString());
              state.listDatas
                  .where((item) => item.id == msgID)
                  .forEach((item) => message = item);

              print(message?.esContent);

              return Text("data");
            },
          ))
        ],
      ),
    );
  }
}
