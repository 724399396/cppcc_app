import 'package:bloc/bloc.dart';
import 'package:cppcc_app/models/contact.dart';
import 'package:cppcc_app/repository/contact_repository.dart';
import 'package:equatable/equatable.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository;

  ContactBloc(this._contactRepository) : super(const ContactState()) {
    on<ContactInitialized>((event, emit) async {
      var contacts = await _contactRepository.getAllContact();
      emit(state.copyWith(contacts: contacts));
    });
  }
}
