part of 'meeting_bloc.dart';

class MeetingState extends Equatable {
  final int unreadCount;
  final ListDataFetchStatus status;
  final Map<String, List<Meeting>> meetings;
  final Map<String, int> currentPage;

  const MeetingState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.meetings = const {},
    this.currentPage = const {},
  });

  MeetingState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    Map<String, List<Meeting>>? meetings,
    Map<String, int>? currentPage,
  }) {
    return MeetingState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      meetings: meetings ?? this.meetings,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  String toString() {
    return 'MeetingState(unreadCount: $unreadCount, status: $status, meetings: $meetings, currentPage: $currentPage)';
  }

  @override
  List<Object> get props => [unreadCount, status, meetings, currentPage];
}
