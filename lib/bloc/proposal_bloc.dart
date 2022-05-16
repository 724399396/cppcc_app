import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/proposal_request.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/proposal.dart';
import 'package:cppcc_app/repository/proposal_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

part 'proposal_event.dart';
part 'proposal_state.dart';

class ProposalBloc extends Bloc<ProposalEvent, ProposalState> {
  final ProposalRepository _proposalRepository;

  ProposalBloc(this._proposalRepository) : super(const ProposalState()) {
    on<ProposalInitialied>((event, emit) async {
      await _proposalRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
    });

    on<ProposalFirstFetch>((event, emit) async {
      if (!state.currentPage.containsKey(event.type)) {
        await _generateCallApi(event, emit, (emit) async {
          await _dataLoad(emit, event.type);
        });
      }
    });

    on<ProposalLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.type);
      });
    });

    on<ProposalRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        Map<ProposalListType, List<Proposal>> newData =
            Map.from(state.proposals);
        newData[event.type] = [];
        Map<ProposalListType, int> newCurrentPage = Map.from(state.currentPage);
        newCurrentPage[event.type] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          proposals: newData,
        ));
        await _dataLoad(emit, event.type);
      });
    });

    on<ProposalAdd>((event, emit) async {
      emit(state.copyWith(submitStatus: FormStatus.submissionInProgress));
      try {
        await _proposalRepository.addProposal(event.request);
        emit(state.copyWith(submitStatus: FormStatus.submissionSuccess));
        event.successCallback();
        // reload data
        add(ProposalInitialied());
      } catch (err) {
        debugPrint('proposal add api error: $err');
        emit(state.copyWith(submitStatus: FormStatus.submissionFailure));
      }
    });

    on<ProposalRead>((event, emit) async {
      await _proposalRepository.getProposalDetail(event.proposal.id);
      Map<ProposalListType, List<Proposal>> newData = Map.from(state.proposals);
      int unreadCount = state.unreadCount;
      for (var key in newData.keys) {
        var proposals = newData[key];
        var readProposal = newData[key]
            ?.firstWhereOrNull((post) => post.id == event.proposal.id);
        if (readProposal != null && !readProposal.read) {
          newData[key] = (proposals
                      ?.where((element) => element.id != event.proposal.id)
                      .toList() ??
                  []) +
              [
                readProposal.copyWith(read: true),
              ];
          unreadCount = unreadCount - 1;
        }
      }
      emit(state.copyWith(proposals: newData, unreadCount: unreadCount));
    });

    on<ProposalProgressGet>((event, emit) async {
      var progress =
          await _proposalRepository.getProposalProgress(event.proposal.id);
      for (var key in state.proposals.keys) {
        var matchProposal = state.proposals[key]
            ?.firstWhereOrNull((post) => post.id == event.proposal.id);
        if (matchProposal != null) {
          emit(state.copyWith(
              currentProposal: matchProposal.copyWith(progress: progress)));
        }
      }
    });
  }

  Future<void> _generateCallApi(ProposalEvent event,
      Emitter<ProposalState> emit, GenericApiCall<ProposalState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      debugPrint('get proposal error: $err');
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(
      Emitter<ProposalState> emit, ProposalListType type) async {
    var proposals = await _proposalRepository.getProposList(
        state.currentPage[type] ?? 1,
        pageSize,
        ProposalListType.excellent == type ? true : null);
    Map<ProposalListType, List<Proposal>> newData = Map.from(state.proposals);
    newData[type] = (newData[type] ?? []) + proposals;
    Map<ProposalListType, int> newCurrentPage = Map.from(state.currentPage);
    newCurrentPage[type] = (newCurrentPage[type] ?? 1) + 1;

    emit(state.copyWith(
      currentPage: newCurrentPage,
      proposals: newData,
    ));
  }
}
