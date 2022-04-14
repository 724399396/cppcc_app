import 'package:cppcc_app/models/meeting.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:flutter/material.dart';

/// 列表项
class MeetingItem extends StatelessWidget {
  final Meeting _meeting;
  const MeetingItem(this._meeting, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.meetingActivitiesDetailsPage,
              arguments: _meeting.id);
        },
        child: Container(
          padding: const EdgeInsets.all(5.0),
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
              Text(
                _meeting.title,
                style: const TextStyle(
                  color: Color(0xff333333),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "时间:" +
                          _meeting.beginDate +
                          " " +
                          _meeting.startTime +
                          "-" +
                          _meeting.endTime,
                      style: const TextStyle(
                        color: Color(0xff999999),
                      ),
                    ),
                  ],
                ),
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
                    Text(
                      "地点:" + _meeting.address,
                      style: const TextStyle(
                        color: Color(0xff999999),
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: _meeting.status == 2
                            ? const Color(0xFF75e287)
                            : const Color(0xFFc6c3bc),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      child: Text(
                        _meeting.statusDictText,
                        style: const TextStyle(
                          color: Color(0xffffffff),
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
