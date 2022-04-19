part of 'contact_bloc.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class ContactInitialized extends ContactEvent {}

class ContactSendBusinessCard extends ContactEvent {
  final String receiverUsername;
  final String message;
  final SuccessCallback successCallback;

  const ContactSendBusinessCard(this.receiverUsername, this.message, this.successCallback);
}
