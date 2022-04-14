part of 'proposal_bloc.dart';

class ProposalState extends Equatable {
  final int unreadCount;

  const ProposalState({this.unreadCount = 0});

  @override
  List<Object> get props => [unreadCount];

  ProposalState copyWith({
    int? unreadCount,
  }) {
    return ProposalState(
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  String toString() => 'ProposalState(unreadCount: $unreadCount)';
}
