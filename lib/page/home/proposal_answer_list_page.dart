import 'package:cppcc_app/bloc/proposal_bloc.dart';
import 'package:cppcc_app/models/proposal.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intl/intl.dart';

class ProposalAnswerListPage extends StatelessWidget {
  const ProposalAnswerListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("答复件列表"),
      ),
      body: Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: BlocBuilder<ProposalBloc, ProposalState>(
        buildWhen: (previous, current) =>
            previous.proposals != current.proposals ||
            previous.status != current.status,
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 8),
              Expanded(
                  child: EasyRefresh.custom(
                enableControlFinishRefresh: true,
                enableControlFinishLoad: true,
                header: easyRefreshHeader,
                footer: easyRefreshFooter,
                onLoad: () async {
                  BlocProvider.of<ProposalBloc>(context)
                      .add(ProposalLoadMore(widget._listType));
                },
                onRefresh: () async {
                  BlocProvider.of<ProposalBloc>(context)
                      .add(ProposalRefresh(widget._listType));
                },
                emptyWidget: filterData.isEmpty ? const EmptyData() : null,
                slivers: filterData.map((p) => ProposalItem(p)).toList(),
              ))
            ],
          );
        },
      ),
      // ),
    );
  }
}

class ProposalItem extends StatelessWidget {
  final Proposal _bean;
  const ProposalItem(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.proposalDetailPage, arguments: _bean);
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        margin: const EdgeInsets.only(bottom: 8),
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
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  Text(
                    _bean.author,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.greyTextColor),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('yyyy-MM-dd').format(_bean.createTime),
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
                          Routes.proposalProgressPage,
                          arguments: _bean);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF66cc00)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      child: Text(
                        _bean.statusDictText,
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
