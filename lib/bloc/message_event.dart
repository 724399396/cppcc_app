part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class MessageInitilized extends MessageEvent {}

class MessageFirstFetch extends MessageEvent {
  final MessageType type;

  const MessageFirstFetch(this.type);
}

class MessageLoadMore extends MessageEvent {
  final MessageType type;

  const MessageLoadMore(this.type);
}

class MessageRefresh extends MessageEvent {
  final MessageType type;

  const MessageRefresh(this.type);
}

class MessageRead extends MessageEvent {
  final Message message;

  const MessageRead(this.message);
}

class MessageReceived extends MessageEvent {
  final MessageReceiveResponse messageReceive;

  const MessageReceived(this.messageReceive);
}
