import 'package:cppcc_app/models/opinions.dart';
import 'package:cppcc_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:cppcc_app/utils/routes.dart';

class OpinionItem extends StatelessWidget {
  final Opinion _opinion;
  const OpinionItem(this._opinion, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.opinionDetailPage, arguments: _opinion);
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _opinion.read
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
                  _opinion.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.black),
                ))
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFc6c3bc),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    child: Text(
                      _opinion.typeDictText,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _opinion.author,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.greyTextColor),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('yyyy-MM-dd').format(_opinion.createTime),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.greyTextColor),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          Routes.opinionProgressPage,
                          arguments: _opinion);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF66cc00)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      child: Text(
                        _opinion.statusDictText,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: const Color(0xFF66cc00)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
