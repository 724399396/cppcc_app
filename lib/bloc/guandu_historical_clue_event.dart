part of 'guandu_historical_clue_bloc.dart';

abstract class GuanduHistoricalClueEvent extends Equatable {
  const GuanduHistoricalClueEvent();

  @override
  List<Object> get props => [];
}

class GuanduHistoricalClueFirstFetch extends GuanduHistoricalClueEvent {}

class GuanduHistoricalClueLoadMore extends GuanduHistoricalClueEvent {}

class GuanduHistoricalClueRefresh extends GuanduHistoricalClueEvent {}

class GuanduHistoricalClueAdd extends GuanduHistoricalClueEvent {
  final GuanduHistoricalClue clue;

  final SuccessCallback successCallback;

  const GuanduHistoricalClueAdd(this.clue, this.successCallback) : super();
}
