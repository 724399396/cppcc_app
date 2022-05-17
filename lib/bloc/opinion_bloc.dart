import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/opinion_request.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/opinions.dart';
import 'package:cppcc_app/repository/opinion_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

part 'opinion_event.dart';
part 'opinion_state.dart';

class OpinionBloc extends Bloc<OpinionEvent, OpinionState> {
  final OpinionRepository _opinionRepository;

  OpinionBloc(this._opinionRepository) : super(const OpinionState()) {
    on<OpinionInitilized>((event, emit) async {
      await _opinionRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
      await _generateCallApi(event, emit, (emit) async {
        for (var type in OpinionListType.values) {
          Map<OpinionListType, List<Opinion>> newOpinions =
              Map.from(state.opinions);
          newOpinions[type] = [];
          Map<OpinionListType, int> newCurrentPage =
              Map.from(state.currentPage);
          newCurrentPage[type] = 1;
          emit(state.copyWith(
            currentPage: newCurrentPage,
            opinions: newOpinions,
          ));
          await _dataLoad(emit, type);
        }
      });
    });

    on<OpinionLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.type);
      });
    });

    on<OpinionRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        Map<OpinionListType, List<Opinion>> newData = Map.from(state.opinions);
        newData[event.type] = [];
        Map<OpinionListType, int> newCurrentPage = Map.from(state.currentPage);
        newCurrentPage[event.type] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          opinions: newData,
        ));
        await _dataLoad(emit, event.type);
      });
    });

    on<OpinionRead>((event, emit) async {
      await _opinionRepository.getOpinionDetail(event.opinion.id);
      Map<OpinionListType, List<Opinion>> newData = Map.from(state.opinions);
      int unreadCount = state.unreadCount;
      for (var key in newData.keys) {
        var opinions = newData[key];
        var readOpinion = newData[key]
            ?.firstWhereOrNull((post) => post.id == event.opinion.id);
        if (readOpinion != null && !readOpinion.read) {
          newData[key] = (opinions
                      ?.where((element) => element.id != event.opinion.id)
                      .toList() ??
                  []) +
              [
                readOpinion.copyWith(read: true),
              ];
          unreadCount = unreadCount - 1;
        }
      }
      emit(state.copyWith(opinions: newData, unreadCount: unreadCount));
    });

    on<OpinionAdd>((event, emit) async {
      emit(state.copyWith(submitStatus: FormStatus.submissionInProgress));
      try {
        await _opinionRepository.addOpinion(event.opinion);
        emit(state.copyWith(submitStatus: FormStatus.submissionSuccess));
        event.successCallback();
        // reload data
        add(OpinionInitilized());
      } catch (err) {
        debugPrint('opinion api error: $err');
        emit(state.copyWith(submitStatus: FormStatus.submissionFailure));
      }
    });

    on<OpinionProgressGet>((event, emit) async {
      var progress =
          await _opinionRepository.getOpinionProgress(event.opinion.id);
      for (var key in state.opinions.keys) {
        var matchOpinion = state.opinions[key]
            ?.firstWhereOrNull((post) => post.id == event.opinion.id);
        if (matchOpinion != null) {
          emit(state.copyWith(
              currentOpinion: matchOpinion.copyWith(progress: progress)));
        }
      }
    });
  }

  Future<void> _generateCallApi(OpinionEvent event, Emitter<OpinionState> emit,
      GenericApiCall<OpinionState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      debugPrint('get opinion error: $err');
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(
      Emitter<OpinionState> emit, OpinionListType type) async {
    var opinions = await _opinionRepository.getOpnionsList(
        state.currentPage[type] ?? 1, pageSize, type.refStatus);
    Map<OpinionListType, List<Opinion>> newData = Map.from(state.opinions);
    newData[type] = (newData[type] ?? []) + opinions;
    Map<OpinionListType, int> newCurrentPage = Map.from(state.currentPage);
    newCurrentPage[type] = (newCurrentPage[type] ?? 1) + 1;

    emit(state.copyWith(
      currentPage: newCurrentPage,
      opinions: newData,
    ));
  }
}
