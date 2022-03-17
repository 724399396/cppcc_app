import 'package:flutter/material.dart';

/// 空数据内容
class EmptyData extends StatefulWidget {
  // 构造函数
  EmptyData({
    Key? key,
  }) : super(key: key);

  @override
  _EmptyDataState createState() => _EmptyDataState();
}

class _EmptyDataState extends State<EmptyData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SizedBox(),
            flex: 2,
          ),
          SizedBox(
            width: 100.0,
            height: 100.0,
            child: new Image.asset('assets/icons/empty_data.png'),
          ),
          Text(
            "当前数据为空！",
            style: TextStyle(fontSize: 16.0, color: Colors.grey[400]),
          ),
          Expanded(
            child: SizedBox(),
            flex: 3,
          ),
        ],
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
