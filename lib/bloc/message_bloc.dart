import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:collection/collection.dart';
import 'package:cppcc_app/dto/message_receive_response.dart';
import 'package:cppcc_app/dto/message_type.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/message.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';

import 'package:cppcc_app/repository/message_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;
  final LocalDataProvider _localDataProvider;
  WebSocketChannel? channel;

  MessageBloc(this._messageRepository, this._localDataProvider)
      : super(const MessageState()) {
    on<MessageInitilized>((event, emit) async {
      channel?.sink.close();
      channel = IOWebSocketChannel.connect(
          Uri.parse('wss://' + baseUrl + '/userMessage/socket'),
          // Uri.parse('ws://' + baseUrl + '/userMessage/socket'),
          headers: {'X-Access-Token': _localDataProvider.token()},
          pingInterval: const Duration(seconds: 1));
      channel!.stream.listen((message) {
        debugPrint(message);
        add(MessageReceived(
            MessageReceiveResponse.fromJson(json.decode(message))));
      });

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

      Map<MessageType, int> newUnreadCount = Map.from(state.unreadCount);
      newUnreadCount[event.message.type] =
          newUnreadCount[event.message.type]! - 1;

      Map<MessageType, List<Message>> newDatas = Map.from(state.messages);
      newDatas[event.message.type] = updateWithGenerateNewList<Message>(
          newDatas[event.message.type] ?? [],
          (message) => message.id == event.message.id,
          (message) => message?.copyWith(read: true));
      emit(state.copyWith(
        messages: newDatas,
        unreadCount: newUnreadCount,
      ));
    }));

    on<MessageReceived>((event, emit) async {
      var newMessage = event.messageReceive;
      MessageType messageType;
      switch (newMessage.type) {
        case 1:
          messageType = MessageType.notice;
          break;
        case 2:
          messageType = MessageType.businessCard;
          break;
        case 3:
        default:
          messageType = MessageType.system;
      }
      Map<MessageType, int> newUnreadCount = Map.from(state.unreadCount);
      newUnreadCount[messageType] = (newUnreadCount[messageType] ?? 0) + 1;
      Map<MessageType, List<Message>> newDatas = Map.from(state.messages);
      var messageData = newMessage.data;
      var exist = newDatas[messageType]
          ?.firstWhereOrNull((element) => element.id == messageData?["id"]);
      if (exist == null) {
        final DateTime now = DateTime.now();
        final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
        final String nowForamtedStr = formatter.format(now);
        newDatas[messageType] = (newDatas[messageType] ?? []) +
            [
              messageType == MessageType.businessCard
                  ? Message(
                      id: messageData?['id'],
                      title: "名片推荐(${messageData?['sendUserDictText']})",
                      msgContent: messageData?['message'] ?? '',
                      sendTime: nowForamtedStr,
                      read: false,
                      type: MessageType.businessCard)
                  : Message(
                      id: messageData?['id'],
                      title: messageData?['title'] ?? '',
                      msgContent: messageData?['msgContent'] ?? '',
                      sendTime: nowForamtedStr,
                      read: false,
                      type: messageType,
                    )
            ];
      }

      emit(state.copyWith(unreadCount: newUnreadCount, messages: newDatas));
    });
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
