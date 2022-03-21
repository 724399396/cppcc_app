import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  final placeholder;
  ChatInput({this.placeholder});
  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.only(left: 15,right: 15),
      decoration: const BoxDecoration(
        color: Color(0xfff33345),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 0.8, color: Color(0xff2D4ED1))), //底部border
              ),
              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: placeholder,
                  contentPadding: EdgeInsets.fromLTRB(
                      0, 17, 15, 15), //输入框内容部分设置padding，跳转跟icon的对其位置
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Container(
            child: SizedBox(
              height: 32.0,
              width: 32.0,
              child: Icon(Icons.message, color: Colors.grey),
            ),
          ),
          Container(
            child: Text('22'),
          ),
          new Divider(height: 1.0),
          Container(
            child: SizedBox(
              height: 32.0,
              width: 32.0,
              child: Icon(Icons.message, color: Colors.grey),
            ),
          ),
          Container(
            child: Text('30'),
          ),
        ],
      ),
    );
  }
}
