part of 'contact_bloc.dart';

class ContactState extends Equatable {
  final List<Contact> contacts;

  final FormStatus? submitStatus;
  final SuccessCallback? successCallback;

  const ContactState({
    this.contacts = const [],
    this.submitStatus,
    this.successCallback,
  });

  ContactState copyWith({
    List<Contact>? contacts,
    FormStatus? submitStatus,
    SuccessCallback? successCallback,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      submitStatus: submitStatus ?? this.submitStatus,
      successCallback: successCallback ?? this.successCallback,
    );
  }

  @override
  String toString() => 'ContactState(contacts: $contacts, submitStatus: $submitStatus, successCallback: $successCallback)';

  @override
  List<Object> get props => [contacts, submitStatus ?? '', successCallback ?? ''];
}
