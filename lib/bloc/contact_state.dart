part of 'contact_bloc.dart';

class ContactState extends Equatable {
  final List<Contact> contacts;

  final FormStatus? status;
  final SuccessCallback? successCallback;

  const ContactState({
    this.contacts = const [],
    this.status,
    this.successCallback,
  });

  ContactState copyWith({
    List<Contact>? contacts,
    FormStatus? status,
    SuccessCallback? successCallback,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      status: status ?? this.status,
      successCallback: successCallback ?? this.successCallback,
    );
  }

  @override
  String toString() =>
      'ContactState(contacts: $contacts, status: $status, successCallback: $successCallback)';

  @override
  List<Object> get props => [contacts, status ?? 0, successCallback ?? 0];
}
