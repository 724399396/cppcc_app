part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class MeetingInitilized extends MeetingEvent {}

class MeetingLoadMore extends MeetingEvent {
  final String type;

  const MeetingLoadMore(this.type);
}

class MeetingRefresh extends MeetingEvent {
  final String type;

  const MeetingRefresh(this.type);
}
