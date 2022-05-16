import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/proposal.dart';
import 'package:cppcc_app/repository/proposal_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
    debugPrint(proposals.toString());
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
