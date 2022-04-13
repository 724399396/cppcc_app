part of 'opinion_bloc.dart';

class OpinionState extends Equatable {
  final int unreadCount;
  final ListDataFetchStatus status;
  final List<Opinion> notDoneOpinions;
  final List<Opinion> doneOpinions;

  const OpinionState({
    this.unreadCount = 0,
    this.status = ListDataFetchStatus.normal,
    this.notDoneOpinions = const [],
    this.doneOpinions = const [],
  });

  @override
  List<Object> get props =>
      [unreadCount, status, notDoneOpinions, doneOpinions];

  OpinionState copyWith({
    int? unreadCount,
    ListDataFetchStatus? status,
    List<Opinion>? notDoneOpinions,
    List<Opinion>? doneOpinions,
  }) {
    return OpinionState(
      unreadCount: unreadCount ?? this.unreadCount,
      status: status ?? this.status,
      notDoneOpinions: notDoneOpinions ?? this.notDoneOpinions,
      doneOpinions: doneOpinions ?? this.doneOpinions,
    );
  }

  @override
  String toString() =>
      'OpinionState(unreadCount: $unreadCount, status: $status)';
}
