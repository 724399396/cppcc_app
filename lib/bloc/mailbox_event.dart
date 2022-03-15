part of 'mailbox_bloc.dart';

abstract class MailboxEvent extends Equatable {
  const MailboxEvent();

  @override
  List<Object> get props => [];
}

class GetMailboxListData extends MailboxEvent {
  final int pageNo;
  final int pageSize;
  final String mailBoxType;

  const GetMailboxListData(this.pageNo, this.pageSize, this.mailBoxType) : super();

  @override
  List<Object> get props => [pageNo, pageSize, mailBoxType];
}
