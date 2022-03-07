part of 'message_bloc.dart';

typedef SuccessCallback = void Function();

abstract class MessageEvent extends Equatable {
  const MessageEvent();

  @override
  List<Object> get props => [];
}

class GetListData extends MessageEvent {
  final int pageNo;
  final int pageSize;

  const GetListData(this.pageNo, this.pageSize) : super();

  @override
  List<Object> get props => [pageNo, pageSize];
}

class MessageInitialed extends MessageEvent {
  const MessageInitialed() : super();
}

class MessageListEvent extends MessageEvent {
  const MessageListEvent() : super();
}
