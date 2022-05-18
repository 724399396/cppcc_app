import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/meeting_change_response.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/meeting.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';
import 'package:cppcc_app/repository/meeting_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MeetingRepository _meetingRepository;
  final LocalDataProvider _localDataProvider;
  WebSocketChannel? channel;

  MeetingBloc(this._meetingRepository, this._localDataProvider)
      : super(const MeetingState()) {
    on<MeetingInitilized>((event, emit) async {
      await _meetingRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
    });

    on<MeetingFirstFetch>((event, emit) async {
      if (!state.currentPage.containsKey(event.type)) {
        await _generateCallApi(event, emit, (emit) async {
          await _dataLoad(emit, event.type);
        });
      }
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

    on<GoMeetingDetail>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _meetingRepository.getMeetingDetail(event.id).then((meeting) {
          emit(state.copyWith(currentMetting: meeting));
        });
        channel?.sink.close();
        channel = IOWebSocketChannel.connect(
            Uri.parse(
                'wss://' + baseUrl + '/meetingActivity/socket/' + event.id),
            // Uri.parse(
            //     'ws://' + baseUrl + '/meetingActivity/socket/' + event.id),
            headers: {'X-Access-Token': _localDataProvider.token()},
            pingInterval: const Duration(seconds: 1));
        channel!.stream.listen((message) {
          debugPrint(message);
          add(MeetingChanged(
              MeetingChangeResponse.fromJson(json.decode(message))));
        });
      });
    });

    on<ApplyLeaveMeeting>((event, emit) async {
      emit(state.copyWith(submitStatus: FormStatus.submissionInProgress));
      try {
        await _meetingRepository.applyLeaveMeeting(
            event.meetingId, event.userId);
        emit(state.copyWith(submitStatus: FormStatus.submissionSuccess));
        event.successCallback();
        await _generateCallApi(event, emit, (emit) async {
          await _meetingRepository
              .getMeetingDetail(event.meetingId)
              .then((meeting) {
            emit(state.copyWith(currentMetting: meeting));
          });
        });
      } catch (err) {
        debugPrint('meeting api error: $err');
        emit(state.copyWith(submitStatus: FormStatus.submissionFailure));
      }
    });

    on<MeetingChanged>((event, emit) async {
      var meetingChange = event.meetingChange;
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
      final String nowForamtedStr = formatter.format(now);
      if (state.currentMetting != null) {
        switch (getMeetingChangeTypeFromCode(meetingChange.type)) {
          case MeetingChangeType.read:
            emit(state.copyWith(
                currentMetting: state.currentMetting?.copyWith(
                    userRecords: updateWithGenerateNewList<MeetingActiveRecord>(
                        state.currentMetting?.userRecords ?? [],
                        (e) => e.userId == meetingChange.userId,
                        (e) => e?.copyWith(read: true)))));
            break;
          case MeetingChangeType.sign:
            emit(state.copyWith(
                currentMetting: state.currentMetting?.copyWith(
                    userRecords: updateWithGenerateNewList<MeetingActiveRecord>(
                        state.currentMetting?.userRecords ?? [],
                        (e) => e.userId == meetingChange.userId,
                        (e) => e?.copyWith(status: 2)))));
            break;
          case MeetingChangeType.broadcast:
            emit(state.copyWith(
                currentMetting: state.currentMetting!.copyWith(
                    broadcasts: state.currentMetting!.broadcasts +
                        [
                          Broadcast(
                              title:
                                  meetingChange.data?['title'] as String? ?? '',
                              content:
                                  meetingChange.data?['content'] as String? ??
                                      '',
                              createTime: nowForamtedStr)
                        ])));
            break;
          case MeetingChangeType.newJoin:
            var originUserRecords = state.currentMetting!.userRecords;
            var existUser = originUserRecords.firstWhereOrNull(
                (element) => element.userId == meetingChange.userId);
            if (existUser == null) {
              emit(state.copyWith(
                  currentMetting: state.currentMetting!.copyWith(
                      userRecords: originUserRecords +
                          [
                            MeetingActiveRecord(
                              read: false,
                              status: 1,
                              userId: meetingChange.userId ?? '',
                              userRealname: meetingChange.userRealname ?? '',
                            )
                          ])));
            }
            break;
          case MeetingChangeType.unknown:
            break;
        }
      }
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
}
