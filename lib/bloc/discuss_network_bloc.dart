import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/discuss_network_change_response.dart';
import 'package:cppcc_app/dto/discuss_network_request.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/discuss_network.dart';
import 'package:cppcc_app/repository/discuss_network_repository.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'discuss_network_event.dart';
part 'discuss_network_state.dart';

class DiscussNetworkBloc
    extends Bloc<DiscussNetworkEvent, DiscussNetworkState> {
  final DiscussNetworkRepository _discussNetworkRepository;
  final LocalDataProvider _localDataProvider;
  WebSocketChannel? channel;

  DiscussNetworkBloc(this._discussNetworkRepository, this._localDataProvider)
      : super(const DiscussNetworkState()) {
    on<DiscussNetworkInitilized>((event, emit) async {
      await _discussNetworkRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
    });

    on<DiscussNetworkLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.type);
      });
    });

    on<DiscussNetworkFirstFetch>((event, emit) async {
      if (!state.currentPage.containsKey(event.type)) {
        await _generateCallApi(event, emit, (emit) async {
          await _dataLoad(emit, event.type);
        });
      }
    });

    on<DiscussNetworkRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        Map<DiscussNetworkListType, List<DiscussNetwork>> newData =
            Map.from(state.data);
        newData[event.type] = [];
        Map<DiscussNetworkListType, int> newCurrentPage =
            Map.from(state.currentPage);
        newCurrentPage[event.type] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          data: newData,
        ));
        await _dataLoad(emit, event.type);
      });
    });

    on<GoDiscussNetworkDetail>((event, emit) async {
      channel?.sink.close();
      channel = IOWebSocketChannel.connect(
          // Uri.parse('wss://' +
          //     baseUrl +
          //     '/discuss/socket/' +
          //     event.discussNetwork.id),
          Uri.parse(
              'ws://' + baseUrl + '/discuss/socket/' + event.discussNetwork.id),
          headers: {'X-Access-Token': _localDataProvider.token()},
          pingInterval: const Duration(seconds: 1));
      channel!.stream.listen((message) {
        debugPrint(message);
        add(DiscussNetowrkChanged(
            DiscussNetworkChangeResponse.fromJson(json.decode(message))));
      });

      DiscussNetwork? currentDiscuss = await _discussNetworkRepository
          .getDiscussNetworkDetail(event.discussNetwork.id);
      Map<DiscussNetworkListType, List<DiscussNetwork>> newData =
          Map.from(state.data);
      int unreadCount = state.unreadCount;
      for (var key in newData.keys) {
        var opinions = newData[key];
        var readDiscussNetwork = newData[key]
            ?.firstWhereOrNull((post) => post.id == event.discussNetwork.id);
        if (readDiscussNetwork != null && !readDiscussNetwork.read) {
          newData[key] = (opinions
                      ?.where(
                          (element) => element.id != event.discussNetwork.id)
                      .toList() ??
                  []) +
              [
                readDiscussNetwork.copyWith(read: true),
              ];
          unreadCount = unreadCount - 1;
        }
      }
      emit(state.copyWith(
          data: newData,
          unreadCount: unreadCount,
          currentDiscuss: currentDiscuss));
    });

    on<DicusssNetworkMsgLike>((event, emit) async {
      emit(state.copyWith(submitStatus: FormStatus.submissionInProgress));
      try {
        await _discussNetworkRepository.userLike(event.id, event.type);
        emit(state.copyWith(submitStatus: FormStatus.submissionSuccess));
        event.successCallback();
      } catch (err) {
        debugPrint('discuss network api error: $err');
        emit(state.copyWith(submitStatus: FormStatus.submissionFailure));
      }
    });

    on<DicusssNetworkMsgSend>((event, emit) async {
      emit(state.copyWith(submitStatus: FormStatus.submissionInProgress));
      try {
        await _discussNetworkRepository.sendMsg(event.request);
        emit(state.copyWith(submitStatus: FormStatus.submissionSuccess));
        event.successCallback();
      } catch (err) {
        debugPrint('discuss network api error: $err');
        emit(state.copyWith(submitStatus: FormStatus.submissionFailure));
      }
    });

    on<DiscussNetowrkChanged>((event, emit) async {
      var change = event.change;
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
      final String nowForamtedStr = formatter.format(now);
      if (state.currentDiscuss != null) {
        switch (getDiscussNetworkChangeTypeFromCode(change.type)) {
          case DiscussNetworkChangeType.newMsg:
            emit(state.copyWith(
                currentDiscuss: state.currentDiscuss?.copyWith(
                    discussMessages: (state.currentDiscuss?.discussMessages ??
                            []) +
                        [
                          DiscussMessage(
                              createTime: nowForamtedStr,
                              id: change.data?['id'] as String? ?? '',
                              message: change.data?['message'] as String? ?? '',
                              ownerAvatar:
                                  change.data?['ownerAvatar'] as String? ?? '',
                              ownerName:
                                  change.data?['ownerName'] as String? ?? '',
                              thumbUpCount: 0,
                              thumbUpStatus: false)
                        ])));
            break;
          case DiscussNetworkChangeType.discussThumsup:
            emit(state.copyWith(
                currentDiscuss: state.currentDiscuss?.copyWith(
                    thumbUpCount: change.thumbUpCount,
                    thumbUpStatus: (state.currentDiscuss?.thumbUpStatus ==
                            false)
                        ? change.thumbUpUserId == _localDataProvider.userId()
                        : true)));
            break;
          case DiscussNetworkChangeType.msgThumsup:
            var prefixMsgs = state.currentDiscuss?.discussMessages
                    .takeWhile((element) => element.id != change.sourceId)
                    .toList() ??
                [];
            var suffixMsgs = state.currentDiscuss?.discussMessages
                    .skipWhile((element) => element.id != change.sourceId)
                    .skip(1)
                    .toList() ??
                [];
            var msg = state.currentDiscuss?.discussMessages
                .firstWhereOrNull((m) => m.id == change.sourceId);
            if (msg != null) {
              emit(state.copyWith(
                  currentDiscuss: state.currentDiscuss?.copyWith(
                      discussMessages: prefixMsgs +
                          [
                            msg.copyWith(
                                thumbUpCount: change.thumbUpCount,
                                thumbUpStatus: (msg.thumbUpStatus == false)
                                    ? change.thumbUpUserId ==
                                        _localDataProvider.userId()
                                    : true)
                          ] +
                          suffixMsgs)));
            }
            break;
          case DiscussNetworkChangeType.newSubMsg:
            // TODO
            break;
          case DiscussNetworkChangeType.unknown:
            break;
        }
      }
    });
  }

  Future<void> _generateCallApi(
      DiscussNetworkEvent event,
      Emitter<DiscussNetworkState> emit,
      GenericApiCall<DiscussNetworkState> call) async {
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
      Emitter<DiscussNetworkState> emit, DiscussNetworkListType type) async {
    var newList = await _discussNetworkRepository.getListPage(
        state.currentPage[type] ?? 1, pageSize, type.refStatus);
    Map<DiscussNetworkListType, List<DiscussNetwork>> newData =
        Map.from(state.data);
    newData[type] = (newData[type] ?? []) + newList;
    Map<DiscussNetworkListType, int> newCurrentPage =
        Map.from(state.currentPage);
    newCurrentPage[type] = (newCurrentPage[type] ?? 1) + 1;

    emit(state.copyWith(
      currentPage: newCurrentPage,
      data: newData,
    ));
  }
}
