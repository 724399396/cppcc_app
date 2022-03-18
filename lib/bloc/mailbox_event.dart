part of 'mailbox_bloc.dart';

typedef SuccessCallback = void Function();

typedef FailCallback = void Function();

abstract class MailboxEvent extends Equatable {
  final SuccessCallback? successCallback;
  final FailCallback? failCallback;

  const MailboxEvent(this.successCallback, this.failCallback);

  @override
  List<Object> get props => [];
}

class GetMailboxListData extends MailboxEvent {
  final int pageNo;
  final int pageSize;
  final String mailBoxType;

  const GetMailboxListData(this.pageNo, this.pageSize, this.mailBoxType)
      : super(null, null);

  @override
  List<Object> get props => [pageNo, pageSize, mailBoxType];
}

class AddMailbox extends MailboxEvent {
  final String type;
  final String title;
  final String content;
  final String userName;
  final String phone;

  const AddMailbox(this.type, this.title, this.content, this.userName,
      this.phone, successCallback, failCallback)
      : super(successCallback, failCallback);

  @override
  List<Object> get props => [type, title, content, userName, phone];
}
