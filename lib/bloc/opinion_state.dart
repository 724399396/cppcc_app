part of 'opinion_bloc.dart';

class OpinionState extends Equatable {
  final int unreadCount;
  final ListDataFetchStatus status;
  final Map<OpinionListType, List<Opinion>> opinions;
  final Map<OpinionListType, int> currentPage;

  const OpinionState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.opinions = const {},
    this.currentPage = const {},
  });

  @override
  List<Object> get props => [unreadCount, status, opinions, currentPage];

  OpinionState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    Map<OpinionListType, List<Opinion>>? opinions,
    Map<OpinionListType, int>? currentPage,
  }) {
    return OpinionState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      opinions: opinions ?? this.opinions,
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  String toString() {
    return 'OpinionState(unreadCount: $unreadCount, status: $status, opinions: $opinions, currentPage: $currentPage)';
  }
}
