import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:cppcc_app/repository/message_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cppcc_app/dto/message/message_entity.dart';

part 'message_event.dart';

part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;

  MessageBloc(this._messageRepository) : super(MessageState()) {
    on<MessageInitialed>((event, emit) async {
      await _messageRepository.getMessageList(1, 10, "").then((result) {
        emit(_populateMessageData(result));
      });
    });

    //请求获取列表数据
    on<GetListData>((event, emit) async {
      await _messageRepository
          .getMessageList(event.pageNo, event.pageSize, event.msgType)
          .then((result) {
        emit(_populateMessageData(result));
      });
    });

    on<MessageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }

  @override
  void onChange(Change<MessageState> change) {
    super.onChange(change);
  }

  _populateMessageData(MessageEntity result) {
    return state.copyWith(result.current, result);
  }
}
