part of 'mailbox_bloc.dart';

class MailboxState extends Equatable {
  final int unreadCount;
  final ListDataFetchStatus status;
  final Map<String, List<Mail>> data;
  final Map<String, int> currentPage;
  const MailboxState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.data = const {},
    this.currentPage = const {},
  });

  MailboxState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    Map<String, List<Mail>>? data,
    Map<String, int>? currentPage,
  }) {
    return MailboxState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  String toString() {
    return 'MailboxState(unreadCount: $unreadCount, status: $status, data: $data, currentPage: $currentPage)';
  }

  @override
  List<Object> get props => [unreadCount, status, data, currentPage];
}
