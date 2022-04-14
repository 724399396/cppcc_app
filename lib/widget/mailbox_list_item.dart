import 'package:flutter/material.dart';

/// 列表项
class MailboxListItem extends StatefulWidget {
  // 点击事件
  final VoidCallback? onPressed;

  // 图标
  final Widget? icon;

  // 标题
  final String? title;

  // 时间
  final String? createTime;

  final Color titleColor;

  // 右侧控件
  final Widget? rightWidget;

  // 构造函数
  MailboxListItem({
    Key? key,
    this.onPressed,
    this.icon,
    this.title,
    this.createTime,
    this.titleColor: Colors.black,
    this.rightWidget,
  }) : super(key: key);

  @override
  _MailboxListItemState createState() => _MailboxListItemState();
}

class _MailboxListItemState extends State<MailboxListItem> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.onPressed,
      padding: EdgeInsets.all(5.0),
      shape: Border.all(
        color: Colors.transparent,
        width: 0.1,
        style: BorderStyle.none,
      ),
      child: Container(
        height: 80.0,
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xfff4f4f4)),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                textDirection: TextDirection.ltr,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Container(
                    child: widget.title != null
                        ? SizedBox(
                            height: 16.0,
                            width: 16.0,
                            child: widget.icon,
                          )
                        : Container(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: widget.title != null
                        ? Text(
                            widget.title!,
                            style: const TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                textDirection: TextDirection.ltr,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Container(
                    child: widget.createTime != null
                        ? Expanded(
                            child: Text(
                              widget.createTime!,
                              maxLines: 100,
                              style: const TextStyle(
                                color: Color(0xff999999),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    child: const SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: Icon(Icons.chevron_right, color: Colors.grey),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
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
