import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/meeting_response.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/meeting.dart';
import 'package:cppcc_app/repository/meeting_repository.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MeetingRepository _meetingRepository;

  MeetingBloc(this._meetingRepository) : super(const MeetingState()) {
    on<MeetingInitilized>((event, emit) async {
      await _meetingRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
      await _generateCallApi(event, emit, (emit) async {
        Map<String, List<Meeting>> newData = Map.from(state.meetings);
        newData["1"] = [];
        Map<String, int> newCurrentPage = Map.from(state.currentPage);
        newCurrentPage["1"] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          meetings: newData,
        ));
        await _dataLoad(emit, "1");
      });
    });

    on<MeetingLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.type);
      });
    });

    on<MeetingRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        Map<String, List<Meeting>> newData = Map.from(state.meetings);
        newData[event.type] = [];
        Map<String, int> newCurrentPage = Map.from(state.currentPage);
        newCurrentPage[event.type] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          meetings: newData,
        ));
        await _dataLoad(emit, event.type);
      });
    });
  }

  Future<void> _generateCallApi(MeetingEvent event, Emitter<MeetingState> emit,
      GenericApiCall<MeetingState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      debugPrint('get meeting error: $err');
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(Emitter<MeetingState> emit, String type) async {
    var meetings = await _meetingRepository.getList(
        state.currentPage[type] ?? 1, pageSize, type);
    Map<String, List<Meeting>> newMeetings = Map.from(state.meetings);
    newMeetings[type] = (newMeetings[type] ?? []) + meetings;
    Map<String, int> newCurrentPage = Map.from(state.currentPage);
    newCurrentPage[type] = (newCurrentPage[type] ?? 1) + 1;

    emit(state.copyWith(
      currentPage: newCurrentPage,
      meetings: newMeetings,
    ));
  }

  @override
  void onChange(Change<MeetingState> change) {
    super.onChange(change);
  }
}
