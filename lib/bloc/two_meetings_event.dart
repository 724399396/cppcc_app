part of 'two_meetings_bloc.dart';

abstract class TwoMeetingsEvent extends Equatable {
  const TwoMeetingsEvent();

  @override
  List<Object> get props => [];
}

class TwoMeetingsInitilized extends TwoMeetingsEvent {}