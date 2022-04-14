import 'package:bloc/bloc.dart';
import 'package:cppcc_app/repository/proposal_repository.dart';
import 'package:equatable/equatable.dart';

part 'proposal_event.dart';
part 'proposal_state.dart';

class ProposalBloc extends Bloc<ProposalEvent, ProposalState> {
  final ProposalRepository _proposalRepository;

  ProposalBloc(this._proposalRepository) : super(const ProposalState()) {
    on<ProposalInitialied>((event, emit) async {
      await _proposalRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
    });
  }
}
