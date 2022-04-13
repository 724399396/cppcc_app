part of 'opinion_bloc.dart';

abstract class OpinionEvent extends Equatable {
  const OpinionEvent();

  @override
  List<Object> get props => [];
}

class OpinionInitilized extends OpinionEvent {}
