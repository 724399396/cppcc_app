part of 'opinion_bloc.dart';

class OpinionState extends Equatable {
  final int unreadCount;
  final ListDataFetchStatus status;
  final Map<OpinionListType, List<Opinion>> opitions;
  final Map<OpinionListType, int> currentPage;

  const OpinionState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.opitions = const {},
    this.currentPage = const {},
  });

  @override
  List<Object> get props => [unreadCount, status, opitions, currentPage];

  OpinionState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    Map<OpinionListType, List<Opinion>>? opitions,
    Map<OpinionListType, int>? currentPage,
  }) {
    return OpinionState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      opitions: opitions ?? this.opitions,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  String toString() {
    return 'OpinionState(unreadCount: $unreadCount, status: $status, opitions: $opitions, currentPage: $currentPage)';
  }
}
