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
  final AddMailRequest request;
  final SuccessCallback? successCallback;

  const AddMailbox(this.request, this.successCallback);
}

class GoMailDetail extends MailboxEvent {
  final String id;

  const GoMailDetail(this.id);
}
