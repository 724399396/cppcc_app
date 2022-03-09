import 'package:flutter/material.dart';

/// 列表项
class NewsListItem extends StatefulWidget {
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

  //阅读量
  final int? hits;

  //资讯类型
  final String? categoryDicttext;

  final Color titleColor;

  // 右侧控件
  final Widget? rightWidget;

  // 构造函数
  NewsListItem({
    Key? key,
    this.onPressed,
    this.icon,
    this.title,
    this.describe,
    this.createTime,
    this.hits,
    this.categoryDicttext,
    this.titleColor: Colors.black,
    this.rightWidget,
  }) : super(key: key);

  @override
  _NewsListItemState createState() => _NewsListItemState();
}

class _NewsListItemState extends State<NewsListItem> {
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
        height: 120.0,
        width: double.infinity,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                textDirection: TextDirection.ltr,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  Container(
                    child: widget.title != null
                        ? Text(
                            widget.title!,
                            style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    child: widget.createTime != null
                        ? Text(
                            widget.createTime!,
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                  )
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
                    child: widget.describe != null
                        ? Expanded(
                            child: Text(
                              widget.describe!,
                              maxLines: 100,
                              style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    child: widget.icon != null
                        ? Container(
                            child: SizedBox(
                              height: 16.0,
                              width: 16.0,
                              child: widget.icon,
                            ),
                          )
                        : Container(
                            width: 14.0,
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
