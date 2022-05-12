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

class OpinionAdd extends OpinionEvent {
  final OpinionAddRequest opinion;
  final SuccessCallback successCallback;

  const OpinionAdd(this.opinion, this.successCallback);
}

class OpinionRead extends OpinionEvent {
  final Opinion opinion;

  const OpinionRead(this.opinion);
}

class OpinionProgressGet extends OpinionEvent {
  final Opinion opinion;

  const OpinionProgressGet(this.opinion);
}