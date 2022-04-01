// ignore_for_file: camel_case_types

import 'package:cppcc_app/bloc/historical_clue_bloc.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GdHistoricalAddPage extends StatefulWidget {
  const GdHistoricalAddPage({Key? key}) : super(key: key);

  @override
  _GdHistoricalAddPageState createState() => _GdHistoricalAddPageState();
}

class _GdHistoricalAddPageState extends State<GdHistoricalAddPage> {
  late String type = "1";
  late String title;
  late String content;
  late String phone;
  late String provider;
  late String unit;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "新增",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xfff27f56),
        elevation: 0.0,
        actions: <Widget>[
          Container(
            width: 60,
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Color(0xfff4f4f4),
            ),
            child: GestureDetector(
              onTap: () {
                BlocProvider.of<HistoricalClueBloc>(context).add(
                    AddHistoricalClue(
                        type, title, content, phone, provider, unit, () {
                  showToast('添加成功');
                  Navigator.of(context).pop();
                }, () {
                  showToast('添加失败');
                }));
              },
              child: const Text("提交"),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfff4f4f4),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.maxFinite,
            padding: EdgeInsets.all(10),
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
                  child: const Text("史料主题",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff292828),
                      )),
                ),
                Container(
                  child: TextFormField(
                    key: const ValueKey('title'),
                    onChanged: (String? val) => title = val!,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1.8,
                            style: BorderStyle.solid),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Color(0xffaaaaaa),
                              ),
                      hintText: '请输入史料主题',
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(bottom: 15),
                  child: const Text("史料有关线索",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff292828),
                      )),
                ),
                Container(
                  child: TextFormField(
                    maxLines: 5,
                    key: const ValueKey('content'),
                    onChanged: (String? val) => content = val!,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1.8,
                            style: BorderStyle.solid),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Color(0xffaaaaaa),
                              ),
                      hintText: '请输入史料有关线索',
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(bottom: 15),
                  child: const Text("史料线索提供人",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff292828),
                      )),
                ),
                Container(
                  child: TextFormField(
                    key: const ValueKey('provider'),
                    onChanged: (String? val) => provider = val!,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1.8,
                            style: BorderStyle.solid),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Color(0xffaaaaaa),
                              ),
                      hintText: '请输入姓名',
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    key: const ValueKey('unit'),
                    onChanged: (String? val) => unit = val!,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1.8,
                            style: BorderStyle.solid),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Color(0xffaaaaaa),
                              ),
                      hintText: '请输入单位名称',
                    ),
                  ),
                ),
                Container(
                  child: TextFormField(
                    key: const ValueKey('phone'),
                    onChanged: (String? val) => phone = val!,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(
                            color: Color(0xfff4f4f4),
                            width: 1.8,
                            style: BorderStyle.solid),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                      hintStyle:
                          Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Color(0xffaaaaaa),
                              ),
                      hintText: '请输入联系电话',
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
