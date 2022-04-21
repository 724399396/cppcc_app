part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();

  @override
  List<Object> get props => [];
}

class MeetingInitilized extends MeetingEvent {}

class MeetingFirstFetch extends MeetingEvent {
  final String type;

  const MeetingFirstFetch(this.type);
}

class MeetingLoadMore extends MeetingEvent {
  final String type;

  const MeetingLoadMore(this.type);
}

class MeetingRefresh extends MeetingEvent {
  final String type;

  const MeetingRefresh(this.type);
}

class GetMeetingDetail extends MeetingEvent {
  final String id;

  const GetMeetingDetail(this.id);
}

class ApplyLeaveMeeting extends MeetingEvent {
  final String meetingId;
  final String userId;
  final SuccessCallback successCallback;

  const ApplyLeaveMeeting(this.meetingId, this.userId, this.successCallback);
}
