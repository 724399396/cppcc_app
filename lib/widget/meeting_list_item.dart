// ignore_for_file: deprecated_member_use
import 'package:cppcc_app/dto/meeting_response.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:flutter/material.dart';

/// 列表项
class MeetingItem extends StatelessWidget {
  final MeetingResponse _bean;
  const MeetingItem(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.meetingActivitiesDetailsPage, arguments: {
          "id": _bean.id,
        });
      },
      child: Container(
        padding: EdgeInsets.all(5.0),
        width: double.infinity,
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
              child: _bean.title != null
                  ? Text(
                      _bean.title!,
                      style: const TextStyle(
                        color: Color(0xff333333),
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container(),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: _bean.beginDate != null
                        ? Text(
                            "时间:" +
                                _bean.beginDate! +
                                " " +
                                _bean.startTime! +
                                "-" +
                                _bean.endTime!,
                            style: const TextStyle(
                              color: Color(0xff999999),
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
                    child: _bean.address != null
                        ? Text(
                            "地点:" + _bean.address!,
                            style: const TextStyle(
                              color: Color(0xff999999),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _bean.status == 2
                          ? const Color(0xFF75e287)
                          : const Color(0xFFc6c3bc),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: _bean.statusDictText != null
                        ? Text(
                            _bean.statusDictText!,
                            style: const TextStyle(
                              color: Color(0xffffffff),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                  ),
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
