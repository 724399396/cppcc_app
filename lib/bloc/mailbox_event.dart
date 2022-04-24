part of 'mailbox_bloc.dart';

abstract class MailboxEvent extends Equatable {
  const MailboxEvent();

  @override
  List<Object> get props => [];
}

class MailboxInitilized extends MailboxEvent {}

class MailboxFirstFetch extends MailboxEvent {
  final String type;

  const MailboxFirstFetch(this.type);
}

class MailboxRefresh extends MailboxEvent {
  final String type;

  const MailboxRefresh(this.type);
}

class MailboxLoadMore extends MailboxEvent {
  final String type;

  const MailboxLoadMore(this.type);
}

class AddMailbox extends MailboxEvent {
  final String type;
  final String title;
  final String content;
  final String userName;
  final String phone;
  final SuccessCallback? successCallback;

  const AddMailbox(this.type, this.title, this.content, this.userName,
      this.phone, this.successCallback);

  @override
  List<Object> get props => [type, title, content, userName, phone];
}
