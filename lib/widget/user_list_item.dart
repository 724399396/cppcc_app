import 'package:flutter/material.dart';

/// 列表项
class UserListItem extends StatelessWidget {
  // 点击事件
  final VoidCallback onClick;

  // 图标
  final Widget icon;

  // 标题
  final String title;

  // 构造函数
  const UserListItem({
    Key? key,
    required this.onClick,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onClick,
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(14.0),
            child: SizedBox(
              height: 32.0,
              width: 32.0,
              child: icon,
            ),
          ),
          Text(title, style: const TextStyle(fontSize: 18)),
          const Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.chevron_right_sharp,
                  color: Color(0xFFe35322),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
