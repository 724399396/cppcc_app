part of 'proposal_bloc.dart';

abstract class ProposalEvent extends Equatable {
  const ProposalEvent();

  @override
  List<Object> get props => [];
}

class ProposalInitialied extends ProposalEvent {}

class ProposalLoadMore extends ProposalEvent {
  final ProposalListType type;

  const ProposalLoadMore(this.type);
}

class ProposalRefresh extends ProposalEvent {
  final ProposalListType type;

  const ProposalRefresh(this.type);
}

class ProposalFirstFetch extends ProposalEvent {
  final ProposalListType type;

  const ProposalFirstFetch(this.type);
}

class ProposalAdd extends ProposalEvent {
  final ProposalAddRequest request;
  final SuccessCallback successCallback;

  const ProposalAdd(this.request, this.successCallback);
}

class ProposalRead extends ProposalEvent {
  final Proposal proposal;

  const ProposalRead(this.proposal);
}

class ProposalProgressGet extends ProposalEvent {
  final Proposal proposal;

  const ProposalProgressGet(this.proposal);
}
