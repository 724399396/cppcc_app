import 'package:flutter/material.dart';

/// 列表项
class MessageListItem extends StatefulWidget {
  // 点击事件
  final VoidCallback? onPressed;

  // 图标
  final Widget? icon;

  // 标题
  final String? title;

  // 描述
  final String? describe;

  // 时间
  final String? createTime;

  final Color titleColor;

  // 右侧控件
  final Widget? rightWidget;

  // 构造函数
  MessageListItem({
    Key? key,
    this.onPressed,
    this.icon,
    this.title,
    this.describe,
    this.createTime,
    this.titleColor: Colors.black,
    this.rightWidget,
  }) : super(key: key);

  @override
  _MessageListItemState createState() => _MessageListItemState();
}

class _MessageListItemState extends State<MessageListItem> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.onPressed,
      padding: EdgeInsets.all(0.0),
      shape: Border.all(
        color: Colors.transparent,
        width: 0.1,
        style: BorderStyle.none,
      ),
      child: Container(
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xfff4f4f4)),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                child: Text("ccc"),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.title != null
                        ? Text(
                            widget.title!,
                            style: TextStyle(
                              color: widget.titleColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Container(
                width: 14.0,
              ),
            ],
          )),
    );
  }
}

/// 空图标
class EmptyIcon extends Icon {
  const EmptyIcon() : super(Icons.hourglass_empty);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
