part of 'proposal_bloc.dart';

class ProposalState extends Equatable {
  final int unreadCount;
  final ListDataFetchStatus status;
  final Map<ProposalListType, List<Proposal>> proposals;
  final Map<ProposalListType, int> currentPage;
  final FormStatus? submitStatus;
  final Proposal? currentProposal;

  const ProposalState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.proposals = const {},
    this.currentPage = const {},
    this.submitStatus,
    this.currentProposal,
  });

  ProposalState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    Map<ProposalListType, List<Proposal>>? proposals,
    Map<ProposalListType, int>? currentPage,
    FormStatus? submitStatus,
    Proposal? currentProposal,
  }) {
    return ProposalState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      proposals: proposals ?? this.proposals,
      currentPage: currentPage ?? this.currentPage,
      submitStatus: submitStatus ?? this.submitStatus,
      currentProposal: currentProposal ?? this.currentProposal,
    );
  }

  @override
  String toString() {
    return 'ProposalState(unreadCount: $unreadCount, status: $status, proposals: $proposals, currentPage: $currentPage, submitStatus: $submitStatus, currentProposal: $currentProposal)';
  }

  @override
  List<Object> get props {
    return [
      unreadCount,
      status,
      proposals,
      currentPage,
      submitStatus ?? '',
      currentProposal ?? '',
    ];
  }
}
