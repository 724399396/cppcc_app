import 'package:cppcc_app/bloc/proposal_bloc.dart';
import 'package:cppcc_app/models/proposal.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/widget/badge_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timelines/timelines.dart';

class ProposalProgressPage extends StatelessWidget {
  const ProposalProgressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProposalBloc>(context).add(ProposalProgressGet(
        ModalRoute.of(context)?.settings.arguments as Proposal));
    return BlocBuilder<ProposalBloc, ProposalState>(
      builder: (context, state) {
        Proposal? _proposal = state.currentProposal;
        int? maxTypeValue = _proposal?.progress
            .map((e) => e.type)
            .reduce((a, b) => a > b ? a : b);
        return Scaffold(
            appBar: AppBar(
              title: const Text("进度"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Timeline.tileBuilder(
                shrinkWrap: true,
                theme: TimelineThemeData(
                    indicatorTheme: const IndicatorThemeData(
                        color: AppColors.greyTextColor),
                    connectorTheme: const ConnectorThemeData(
                        color: AppColors.greyTextColor, thickness: 1)),
                builder: TimelineTileBuilder.connected(
                  nodePositionBuilder: (context, index) => 0,
                  indicatorPositionBuilder: (context, index) => 0,
                  indicatorBuilder: (_, index) {
                    return Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40))),
                          child: Center(child: Text((index + 1).toString())),
                        ),
                        index == _proposal!.progress.length - 1
                            ? Container()
                            : Container(
                                width: 2,
                                height: 70,
                                color: Colors.grey,
                              )
                      ],
                    );
                  },
                  contentsAlign: ContentsAlign.basic,
                  contentsBuilder: (context, index) {
                    ProposalProgress progress = _proposal!.progress[index];
                    return Container(
                      padding: const EdgeInsets.only(left: 8),
                      child: ProposalProgressItem(
                          progress, progress.type < (maxTypeValue ?? 0)),
                    );
                  },
                  itemCount: _proposal?.progress.length ?? 0,
                ),
              ),
            ));
      },
    );
  }
}

class ProposalProgressItem extends StatelessWidget {
  final ProposalProgress _bean;
  final bool _done;
  const ProposalProgressItem(this._bean, this._done, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          constraints: const BoxConstraints(minHeight: 90),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _bean.content
                      .map((e) => Row(
                            children: [
                              Text(e.key),
                              const Text(':'),
                              const SizedBox(width: 4),
                              Text(e.value),
                            ],
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
              foregroundDecoration: BadgeDecoration(
            badgeColor: _done ? AppColors.appGreen : const Color(0xFFbdc7d0),
            badgeSize: 60,
            textSpan: TextSpan(
              text: _bean.typeDictText,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          )),
        )
      ],
    );
  }
}
