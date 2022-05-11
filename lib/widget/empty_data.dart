import 'package:flutter/material.dart';

/// 空数据内容
class EmptyData extends StatelessWidget {
  // 构造函数
  const EmptyData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Container(),
            flex: 2,
          ),
          SizedBox(
            width: 100.0,
            height: 100.0,
            child: Image.asset('assets/icons/empty_data.png'),
          ),
          const SizedBox(height: 8),
          Text(
            "暂无数据！",
            style: TextStyle(fontSize: 16.0, color: Colors.grey[400]),
          ),
          Expanded(
            child: Container(),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
