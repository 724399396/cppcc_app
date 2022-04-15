part of 'contact_bloc.dart';

class ContactState extends Equatable {
  final List<Contact> contacts;
  const ContactState({
    this.contacts = const [],
  });

  ContactState copyWith({
    List<Contact>? contacts,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  String toString() => 'ContactState(contacts: $contacts)';

  @override
  List<Object> get props => [contacts];
}
