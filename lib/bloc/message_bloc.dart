import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/message_type.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/message.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';

import 'package:cppcc_app/repository/message_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;

  MessageBloc(this._messageRepository) : super(const MessageState()) {
    on<MessageInitilized>((event, emit) async {
      await Future.wait([
        _messageRepository.getUnreadCount(MessageType.notice),
        _messageRepository.getUnreadCount(MessageType.businessCard),
        _messageRepository.getUnreadCount(MessageType.system)
      ]).then((values) {
        emit(state.copyWith(unreadCount: {
          MessageType.notice: values[0],
          MessageType.businessCard: values[1],
          MessageType.system: values[2]
        }));
      });
    });

    on<MessageFirstFetch>((event, emit) async {
      if (!state.currentPage.containsKey(event.type)) {
        await _generateCallApi(event, emit, (emit) async {
          await _dataLoad(emit, event.type);
        });
      }
    });

    on<MessageLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.type);
      });
    });

    on<MessageRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        Map<MessageType, List<Message>> newData = Map.from(state.messages);
        newData[event.type] = [];
        Map<MessageType, int> newCurrentPage = Map.from(state.currentPage);
        newCurrentPage[event.type] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          messages: newData,
        ));
        await _dataLoad(emit, event.type);
      });
    });

    on<MessageRead>(((event, emit) async {
      await _messageRepository.readMessage(event.message);

      Map<MessageType, List<Message>> newDatas = Map.from(state.messages);

      newDatas[event.message.type] = newDatas[event.message.type]!
              .where((element) => element.id != event.message.id)
              .toList() +
          [event.message.copyWith(read: true)];
      emit(state.copyWith(messages: newDatas));
    }));
  }

  Future<void> _generateCallApi(MessageEvent event, Emitter<MessageState> emit,
      GenericApiCall<MessageState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      debugPrint('get Message error: $err');
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(Emitter<MessageState> emit, MessageType type) async {
    List<Message> messages;
    switch (type) {
      case MessageType.notice:
        messages = await _messageRepository.getSystemList(
            state.currentPage[type] ?? 1, pageSize, type);
        break;
      case MessageType.businessCard:
        messages = await _messageRepository.getBusinessCardList(
            state.currentPage[type] ?? 1, pageSize);
        break;
      case MessageType.system:
        messages = await _messageRepository.getSystemList(
            state.currentPage[type] ?? 1, pageSize, type);
        break;
    }
    Map<MessageType, List<Message>> newDatas = Map.from(state.messages);
    newDatas[type] = (newDatas[type] ?? []) + messages;
    Map<MessageType, int> newCurrentPage = Map.from(state.currentPage);
    newCurrentPage[type] = (newCurrentPage[type] ?? 1) + 1;

    emit(state.copyWith(
      currentPage: newCurrentPage,
      messages: newDatas,
    ));
  }
}
