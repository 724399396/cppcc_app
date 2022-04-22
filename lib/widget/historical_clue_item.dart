import 'package:cppcc_app/models/guandu_historical_clue.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:flutter/material.dart';

/// 列表项

class HistoricalClueItem extends StatelessWidget {
  final GuanduHistoricalClue _bean;
  const HistoricalClueItem(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.guanduHistoricalDetailsPage, arguments: _bean);
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Color(0xfff4f4f4)),
          ),
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
                  Text(
                    _bean.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFc6c3bc),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 4),
                        child: Text(
                          _bean.provider,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _bean.unit,
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
          ],
        ),
      ),
    );
  }
}
