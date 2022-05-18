import 'package:cppcc_app/models/mail.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:flutter/material.dart';

class MailboxListItem extends StatelessWidget {
  final Mail _bean;
  // 构造函数
  const MailboxListItem(
    this._bean, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.leaderMailboxDetailsPage, arguments: _bean);
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.all(8),
          constraints: const BoxConstraints(minHeight: 80),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 24,
                    child: Icon(Icons.mail_outline,
                        color: _bean.read
                            ? Colors.grey
                            : (_bean.type == 1
                                ? const Color(0xfffa8638)
                                : (_bean.type == 2
                                    ? const Color(0xff6497fc)
                                    : const Color(0xff6cd47a)))),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _bean.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _bean.createTime,
                      style: const TextStyle(
                        color: AppColors.greyTextColor,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                    child: Icon(Icons.chevron_right, color: AppColors.greyTextColor),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
