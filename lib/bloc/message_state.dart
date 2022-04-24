part of 'message_bloc.dart';

class MessageState extends Equatable {
  final ListDataFetchStatus status;
  final Map<MessageType, int> unreadCount;
  final Map<MessageType, List<Message>> messages;
  final Map<MessageType, int> currentPage;
  const MessageState({
    this.status = ListDataFetchStatus.normal,
    this.unreadCount = const {},
    this.messages = const {},
    this.currentPage = const {},
  });

  MessageState copyWith({
    ListDataFetchStatus? status,
    Map<MessageType, int>? unreadCount,
    Map<MessageType, List<Message>>? messages,
    Map<MessageType, int>? currentPage,
  }) {
    return MessageState(
      status: status ?? this.status,
      unreadCount: unreadCount ?? this.unreadCount,
      messages: messages ?? this.messages,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  String toString() {
    return 'MessageState(status: $status, unreadCount: $unreadCount, messages: $messages, currentPage: $currentPage)';
  }

  @override
  List<Object> get props => [status, unreadCount, messages, currentPage];
}
