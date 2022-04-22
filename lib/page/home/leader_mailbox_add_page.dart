import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/dto/login_response.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderMailboxAddPage extends StatefulWidget {
  const LeaderMailboxAddPage({Key? key}) : super(key: key);

  @override
  _LeaderMailboxAddPageState createState() => _LeaderMailboxAddPageState();
}

class _LeaderMailboxAddPageState extends State<LeaderMailboxAddPage> {
  late String type = "1";
  late String title;
  late String content;
  late String userName;
  late String phone;

  late List<DictItem> _dictItems;

  @override
  Widget build(BuildContext context) {
    DictService().getDictItemByCode(DictService().mailboxType).then((datas) => {
          setState(() {
            _dictItems = datas;
            type = datas.last.itemValue;
          })
        });

    return Scaffold(
      appBar: AppBar(
        title: const Text( "我要写信"),
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
                BlocProvider.of<MailboxBloc>(context)
                    .add(AddMailbox(type, title, content, userName, phone, () {
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
                  child: const Text("信箱类型",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff292828),
                      )),
                ),
                Container(
                  child: DropdownButton<String>(
                    value: type,
                    isExpanded: true,
                    hint: Text(
                      '请选择',
                      style: TextStyle(),
                    ),
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Color(0xff292828),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    items: _dictItems.map((DictItem value) {
                      return DropdownMenuItem<String>(
                        value: value.itemValue,
                        child: new Text(value.itemText),
                      );
                    }).toList(),
                    onChanged: (String? val) => type = val!,
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(bottom: 15),
                  child: const Text("姓名",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff292828),
                      )),
                ),
                Container(
                  child: TextFormField(
                    key: const ValueKey('userId'),
                    onChanged: (String? val) => userName = val!,
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
                  width: double.maxFinite,
                  padding: EdgeInsets.only(bottom: 15),
                  child: const Text("联系电话",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff292828),
                      )),
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
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(bottom: 15),
                  child: const Text("标题(必填)",
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
                      hintText: '请输入标题(必填)',
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(bottom: 15),
                  child: const Text("请输入描述",
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
                      hintText: '请输入描述',
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
