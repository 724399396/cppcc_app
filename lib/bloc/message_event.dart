part of 'message_bloc.dart';

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetListData extends MessageEvent {
  final int pageNo;
  final int pageSize;
  final String msgType;

  const GetListData(this.pageNo, this.pageSize, this.msgType) : super();

  @override
  List<Object> get props => [pageNo, pageSize, msgType];
}

class GetDetailsData extends MessageEvent {
  final String id;

  const GetDetailsData(this.id) : super();

  @override
  List<Object> get props => [id];
}

class MessageInitialed extends MessageEvent {
  const MessageInitialed() : super();
}

class MessageListEvent extends MessageEvent {
  const MessageListEvent() : super();
}
