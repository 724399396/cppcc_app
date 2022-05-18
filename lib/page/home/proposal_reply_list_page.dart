import 'package:cppcc_app/bloc/proposal_bloc.dart';
import 'package:cppcc_app/models/proposal.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProposalReplyListPage extends StatelessWidget {
  const ProposalReplyListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Proposal _bean =
        ModalRoute.of(context)?.settings.arguments as Proposal;
    return Scaffold(
      appBar: AppBar(
        title: const Text("答复件列表"),
      ),
      body: Container(
        color: AppColors.background,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: BlocBuilder<ProposalBloc, ProposalState>(
          buildWhen: (previous, current) =>
              previous.proposals != current.proposals ||
              previous.status != current.status,
          builder: (context, state) {
            return _bean.replyFiles.isEmpty
                ? const EmptyData()
                : ListView(
                    children:
                        _bean.replyFiles.map((p) => ReplyItem(p)).toList(),
                  );
          },
        ),
      ),
    );
  }
}

class ReplyItem extends StatelessWidget {
  final ReplyFile _bean;
  const ReplyItem(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
    Navigator.of(context)
        .pushNamed(Routes.replayDetailPage, arguments: _bean);
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 8),
              Text(
                _bean.authorRealname,
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
            ],
          ),
        ),
      ],
    ),
      ),
    );
  }
}
