import 'package:cppcc_app/models/message.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class MessageListItem extends StatelessWidget {
  final Message _bean;

  const MessageListItem(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.messageDetailsPage, arguments: _bean);
        },
        child: Container(
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _bean.read
                      ? Container()
                      : Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.only(right: 8),
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFfa7c2f),
                          )),
                  Expanded(
                    child: Text(_bean.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  Text(
                    _bean.sendTime,
                    style: themeData.textTheme.caption
                        ?.copyWith(color: AppColors.greyTextColor),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Html(
                      data: _bean.msgContent,
                      tagsList: Html.tags..addAll(["bird", "flutter"]),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                    width: 16.0,
                    child: Icon(Icons.chevron_right, color: Colors.grey),
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
