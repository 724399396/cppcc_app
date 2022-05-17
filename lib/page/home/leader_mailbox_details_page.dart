import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/models/mail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

class LeaderMailboxDetailsPage extends StatelessWidget {
  const LeaderMailboxDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Mail _bean = ModalRoute.of(context)?.settings.arguments as Mail;

    return Scaffold(
        appBar: AppBar(
          title: const Text("详情"),
        ),
        body: BlocBuilder<MailboxBloc, MailboxState>(
          builder: (context, state) {
            return ListView(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  decoration: const BoxDecoration(),
                  child: Text(_bean.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff333333),
                      )),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFc6c3bc),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        child: Text(
                          _bean.typeDictText,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(_bean.userRealname,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Color(0xff999999),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: _bean.content != ""
                      ? Html(
                          data: _bean.content,
                          tagsList: Html.tags..addAll(["bird", "flutter"]),
                        )
                      : Container(),
                ),
                // 顶部栏
              ],
            );
          },
        ));
  }
}
