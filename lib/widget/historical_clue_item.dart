import 'package:cppcc_app/models/guandu_historical_clue.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:flutter/material.dart';

class HistoricalClueItem extends StatelessWidget {
  final GuanduHistoricalClue _bean;
  const HistoricalClueItem(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(Routes.guanduHistoricalDetailsPage,
                arguments: _bean);
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
                      ),
                    ),
                  ],
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
                    const SizedBox(width: 8),
                    Text(
                      _bean.createTime,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColors.greyTextColor),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
