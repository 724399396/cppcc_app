import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/models/contact.dart';
import 'package:cppcc_app/repository/contact_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository _contactRepository;

  ContactBloc(this._contactRepository) : super(const ContactState()) {
    on<ContactInitialized>((event, emit) async {
      var contacts = await _contactRepository.getAllContact();
      emit(state.copyWith(contacts: contacts));
    });
    on<ContactSendBusinessCard>((event, emit) async {
      emit(state.copyWith(submitStatus: FormStatus.submissionInProgress));
      try {
        await _contactRepository.sendBusinessCard(event.receiverUsername, event.message);
        emit(state.copyWith(
            submitStatus: FormStatus.submissionSuccess,
            successCallback: event.successCallback));
      } catch (err) {
        debugPrint('contact api error: $err');
        emit(state.copyWith(submitStatus: FormStatus.submissionFailure));
      }
    });
  }

  @override
  void onChange(Change<ContactState> change) {
    super.onChange(change);
    if (change.nextState.submitStatus == FormStatus.submissionSuccess &&
        change.nextState.successCallback != null) {
      change.nextState.successCallback!();
    }
  }
}
