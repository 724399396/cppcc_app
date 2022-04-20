part of 'two_meetings_bloc.dart';

class TwoMeetingsState extends Equatable {
  final ListDataFetchStatus status;
  final List<TwoMeetings> meetings;
  final int currentPage;
  const TwoMeetingsState({
    this.status = ListDataFetchStatus.normal,
    this.meetings = const [],
    this.currentPage = 1,
  });

  TwoMeetingsState copyWith({
    ListDataFetchStatus? status,
    List<TwoMeetings>? meetings,
    int? currentPage,
  }) {
    return TwoMeetingsState(
      status: status ?? this.status,
      meetings: meetings ?? this.meetings,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  String toString() =>
      'TwoMeetingsState(status: $status, meetings: $meetings, currentPage: $currentPage)';

  @override
  List<Object> get props => [status, meetings, currentPage];
}
