part of 'meeting_bloc.dart';

class MeetingState extends Equatable with WithListFetchState {
  final int unreadCount;
  final ListDataFetchStatus status;
  final Map<String, List<Meeting>> meetings;
  final Map<String, int> currentPage;
  final MeetingDetail? currentMetting;

  final FormStatus? submitStatus;

  const MeetingState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.meetings = const {},
    this.currentPage = const {},
    this.currentMetting,
    this.submitStatus,
  });

  MeetingState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    Map<String, List<Meeting>>? meetings,
    Map<String, int>? currentPage,
    MeetingDetail? currentMetting,
    FormStatus? submitStatus,
  }) {
    return MeetingState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      meetings: meetings ?? this.meetings,
      currentPage: currentPage ?? this.currentPage,
      currentMetting: currentMetting ?? this.currentMetting,
      submitStatus: submitStatus ?? this.submitStatus,
    );
  }

  @override
  String toString() {
    return 'MeetingState(unreadCount: $unreadCount, status: $status, meetings: $meetings, currentPage: $currentPage, currentMetting: $currentMetting, submitStatus: $submitStatus)';
  }

  @override
  List<Object> get props {
    return [
      unreadCount,
      status,
      meetings,
      currentPage,
      currentMetting ?? '',
      submitStatus ?? '',
    ];
  }

  @override
  ListDataFetchStatus listFetchStatus() {
    return status;
  }
}
