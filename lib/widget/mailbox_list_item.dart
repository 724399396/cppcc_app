import 'package:cppcc_app/models/mail.dart';
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
          height: 80.0,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color(0xfff4f4f4)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                textDirection: TextDirection.ltr,
                verticalDirection: VerticalDirection.down,
                children: <Widget>[
                  SizedBox(
                    height: 16.0,
                    width: 16.0,
                    child: Icon(Icons.mail,
                        color: _bean.read
                            ? Colors.grey
                            : (_bean.type == 1
                                ? const Color(0xfffa8638)
                                : (_bean.type == 2
                                    ? const Color(0xff6497fc)
                                    : const Color(0xff6cd47a)))),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      _bean.title,
                      style: const TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  textDirection: TextDirection.ltr,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _bean.createTime,
                        maxLines: 100,
                        style: const TextStyle(
                          color: Color(0xff999999),
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: Icon(Icons.chevron_right, color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
