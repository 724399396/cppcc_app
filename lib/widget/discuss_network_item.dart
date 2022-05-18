import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/models/discuss_network.dart';
import 'package:cppcc_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:intl/intl.dart';

class DiscussNetworkItem extends StatelessWidget {
  final DiscussNetwork _bean;
  const DiscussNetworkItem(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusColor =
        _bean.status == 2 ? const Color(0xff3a6cea) : AppColors.greyTextColor;
    return SliverToBoxAdapter(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(Routes.discussNetworkDetailsPage, arguments: _bean);
        },
        child: Container(
          height: 120,
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
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
                            child: Text(
                          _bean.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.black),
                        ))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: statusColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          child: Text(
                            _bean.statusDictText.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: statusColor),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          DateFormat("yyyy-MM-dd").format(DateTime.parse(_bean.createTime)),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.greyTextColor),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _bean.thumbUpCount.toString() + '点赞',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppColors.greyTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 120,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: _bean.cover == null
                        ? Image.asset('assets/icons/ic_news.png')
                        : CachedNetworkImage(
                            imageUrl: _bean.cover!,
                            fit: BoxFit.cover,
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
