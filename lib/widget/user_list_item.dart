import 'package:flutter/material.dart';

/// 列表项
class UserListItem extends StatefulWidget {
  // 点击事件
  final VoidCallback? onPressed;

  // 图标
  final Widget? icon;

  // 标题
  final String? title;
  final Color titleColor;

  // 右侧控件
  final Widget? rightWidget;

  // 构造函数
  UserListItem({
    Key? key,
    this.onPressed,
    this.icon,
    this.title,
    this.titleColor: Colors.black,
    this.rightWidget,
  }) : super(key: key);

  @override
  _UserListItemState createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
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
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xfff4f4f4)),
            ),
          ),
          child: Row(
            children: <Widget>[
              widget.icon != null
                  ? Container(
                      padding: EdgeInsets.all(14.0),
                      child: SizedBox(
                        height: 32.0,
                        width: 32.0,
                        child: widget.icon,
                      ),
                    )
                  : Container(
                      width: 14.0,
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
