import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/guandu_historical_clue.dart';
import 'package:cppcc_app/repository/guandu_historical_clue_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'guandu_historical_clue_event.dart';
part 'guandu_historical_clue_state.dart';

class GuanduHistoricalClueBloc
    extends Bloc<GuanduHistoricalClueEvent, GuanduHistoricalClueState> {
  final GuanduHistoricalClueRepository _historicalClueRepository;

  GuanduHistoricalClueBloc(this._historicalClueRepository)
      : super(const GuanduHistoricalClueState()) {
    on<GuanduHistoricalClueFirstFetch>((event, emit) async {
      if (state.currentPage == 0) {
        emit(state.copyWith(currentPage: 1));
        await _generateCallApi(event, emit, (emit) async {
          await _dataLoad(emit);
        });
      }
    });

    on<GuanduHistoricalClueLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit);
      });
    });

    on<GuanduHistoricalClueRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        emit(state.copyWith(
          currentPage: 1,
          data: [],
        ));
        await _dataLoad(emit);
      });
    });

    //添加领导信箱
    on<AddHistoricalClue>((event, emit) async {
      emit(state.copyWith(submitStatus: FormStatus.submissionInProgress));
      try {
        await _historicalClueRepository.addHistoricalClue(event.title,
            event.unit, event.provider, event.phone, event.content);
        emit(state.copyWith(submitStatus: FormStatus.submissionSuccess));
        event.successCallback();
      } catch (err) {
        debugPrint('meeting api error: $err');
        emit(state.copyWith(submitStatus: FormStatus.submissionFailure));
      }
    });
  }

  Future<void> _generateCallApi(
      GuanduHistoricalClueEvent event,
      Emitter<GuanduHistoricalClueState> emit,
      GenericApiCall<GuanduHistoricalClueState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      debugPrint('get historical clu error: $err');
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(Emitter<GuanduHistoricalClueState> emit) async {
    var newData =
        await _historicalClueRepository.getList(state.currentPage, pageSize);
    emit(state.copyWith(
      currentPage: state.currentPage + 1,
      data: state.data + newData,
    ));
  }
}
