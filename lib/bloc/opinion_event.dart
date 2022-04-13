part of 'opinion_bloc.dart';

abstract class OpinionEvent extends Equatable {
  const OpinionEvent();

  @override
  List<Object> get props => [];
}

class OpinionInitilized extends OpinionEvent {}

class OpinionLoadMore extends OpinionEvent {
  final OpinionListType type;

  const OpinionLoadMore(this.type);
}

class OpinionRefresh extends OpinionEvent {
  final OpinionListType type;

  const OpinionRefresh(this.type);
}
