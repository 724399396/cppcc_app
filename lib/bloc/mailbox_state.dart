part of 'mailbox_bloc.dart';

class MailboxState extends Equatable {
  final int unreadCount;
  final ListDataFetchStatus status;
  final Map<String, List<Mail>> data;
  final Map<String, int> currentPage;
  final FormStatus? submitStatus;
  final Mail? currentMail;
  const MailboxState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.data = const {},
    this.currentPage = const {},
    this.submitStatus,
    this.currentMail,
  });

  MailboxState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    Map<String, List<Mail>>? data,
    Map<String, int>? currentPage,
    FormStatus? submitStatus,
    Mail? currentMail,
  }) {
    return MailboxState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      submitStatus: submitStatus ?? this.submitStatus,
      currentMail: currentMail ?? this.currentMail,
    );
  }

  @override
  String toString() {
    return 'MailboxState(unreadCount: $unreadCount, status: $status, data: $data, currentPage: $currentPage, submitStatus: $submitStatus, currentMail: $currentMail)';
  }

  @override
  List<Object> get props {
    return [
      unreadCount,
      status,
      data,
      currentPage,
      submitStatus ?? '',
      currentMail ?? '',
    ];
  }
}
