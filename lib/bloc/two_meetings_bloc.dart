import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/two_meetings.dart';
import 'package:cppcc_app/repository/two_meetings_repository.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'two_meetings_event.dart';
part 'two_meetings_state.dart';

class TwoMeetingsBloc extends Bloc<TwoMeetingsEvent, TwoMeetingsState> {
  final TwoMeetingsRepository _twoMeetingsRepository;

  TwoMeetingsBloc(this._twoMeetingsRepository)
      : super(const TwoMeetingsState()) {
    on<TwoMeetingsInitilized>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        emit(state.copyWith(
          currentPage: 1,
          meetings: [],
        ));
        await _dataLoad(emit);
      });
    });
  }

  Future<void> _generateCallApi(
      TwoMeetingsEvent event,
      Emitter<TwoMeetingsState> emit,
      GenericApiCall<TwoMeetingsState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      debugPrint('get two meeting error: $err');
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(Emitter<TwoMeetingsState> emit) async {
    var meetings =
        await _twoMeetingsRepository.getList(state.currentPage, pageSize);

    emit(state.copyWith(
      currentPage: state.currentPage + 1,
      meetings: meetings,
    ));
  }
}
