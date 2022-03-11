import 'package:flutter/material.dart';
import 'package:cppcc_app/dto/message/message_entity.dart';
import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "建议反馈",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xfff27f56),
        elevation: 0.0,
        actions: <Widget>[
          Container(
            width: 60,
            padding: new EdgeInsets.all(5),
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Color(0xfff4f4f4),
            ),
            child: const Text("提交"),
          ),
        ],
      ),
      backgroundColor: Color(0xfff4f4f4),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(child: BlocBuilder<MessageBloc, MessageState>(
            builder: (context, state) {
              // print("====listDatas====" + state.listDatas.length.toString());
              return Container(
                width: double.infinity,
                height: double.maxFinite,
                padding: new EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
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
                      padding: EdgeInsets.only(bottom: 15),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom:
                              BorderSide(width: 1, color: Color(0xfff4f4f4)),
                        ),
                      ),
                      child: const Text("您的建议与反馈",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xff292828),
                          )),
                    ),
                    Container(
                      child: TextField(
                        key: const ValueKey('keyword'),
                        maxLines: 15,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.0,
                                style: BorderStyle.solid),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            borderSide: BorderSide(
                                color: Colors.white,
                                width: 0.0,
                                style: BorderStyle.solid),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.all(8),
                          hintStyle:
                              Theme.of(context).textTheme.bodyText1?.copyWith(
                                    color: Color(0xffaaaaaa),
                                  ),
                          hintText: '请输入关键词',
                        ),
                        onSubmitted: (value) {
                          print("object");
                        },
                        textInputAction: TextInputAction.search,
                      ),
                    ),
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
