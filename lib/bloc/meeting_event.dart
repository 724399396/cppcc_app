part of 'meeting_bloc.dart';

typedef SuccessCallback = void Function();

typedef FailCallback = void Function();

abstract class MeetingEvent extends Equatable {
  final SuccessCallback? successCallback;
  final FailCallback? failCallback;

  const MeetingEvent(this.successCallback, this.failCallback);

  @override
  List<Object> get props => [];
}

class GetMeetingListData extends MeetingEvent {
  final int pageNo;
  final int pageSize;
  final String type;

  const GetMeetingListData(this.pageNo, this.pageSize, this.type)
      : super(null, null);

  @override
  List<Object> get props => [pageNo, pageSize, type];
}

class AddMeeting extends MeetingEvent {
  final String type;
  final String title;
  final String content;
  final String userName;
  final String phone;

  const AddMeeting(this.type, this.title, this.content, this.userName,
      this.phone, successCallback, failCallback)
      : super(successCallback, failCallback);

  @override
  List<Object> get props => [type, title, content, userName, phone];
}
