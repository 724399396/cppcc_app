import 'package:cppcc_app/models/meeting.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/badge_decoration.dart';
import 'package:flutter/material.dart';

/// 列表项
class MeetingItem extends StatelessWidget {
  final Meeting _meeting;
  const MeetingItem(this._meeting, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var readingColor =
        (_meeting.read ?? false) ? AppColors.greyTextColor : AppColors.appBlue;
    var themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(Routes.meetingActivitiesDetailsPage,
              arguments: _meeting.id);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          _meeting.title,
                          style: themeData.textTheme.titleLarge,
                        )),
                        // 为右上角的标记流出空间避免重叠
                        const SizedBox(width: 40),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "活动时间: " +
                          _meeting.beginDate +
                          " " +
                          _meeting.startTime.substring(0, 5) +
                          "-" +
                          _meeting.endTime.substring(0, 5),
                      style: themeData.textTheme.bodyText2
                          ?.copyWith(color: AppColors.greyTextColor),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "活动地点: " + _meeting.address,
                          style: themeData.textTheme.bodyText2
                              ?.copyWith(color: AppColors.greyTextColor),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: readingColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 4),
                          child: Text(
                            (_meeting.read ?? false) ? "已阅读" : "未阅读",
                            style: TextStyle(
                              color: readingColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                    foregroundDecoration: BadgeDecoration(
                  badgeColor: _meeting.status == 1
                      ? AppColors.appBlue
                      : (_meeting.status == 2
                          ? AppColors.appGreen
                          : const Color(0xFFbdc7d0)),
                  badgeSize: 60,
                  textSpan: TextSpan(
                    text: _meeting.status == 1
                        ? '未开始'
                        : (_meeting.status == 2 ? '进行中' : '已结束'),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
