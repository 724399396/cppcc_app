part of 'proposal_bloc.dart';

abstract class ProposalEvent extends Equatable {
  const ProposalEvent();

  @override
  List<Object> get props => [];
}

class ProposalInitialied extends ProposalEvent {

}