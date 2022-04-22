part of 'guandu_historical_clue_bloc.dart';

abstract class GuanduHistoricalClueEvent extends Equatable {
  const GuanduHistoricalClueEvent();

  @override
  List<Object> get props => [];
}

class GuanduHistoricalClueFirstFetch extends GuanduHistoricalClueEvent {}

class GuanduHistoricalClueLoadMore extends GuanduHistoricalClueEvent {}

class GuanduHistoricalClueRefresh extends GuanduHistoricalClueEvent {}

class AddHistoricalClue extends GuanduHistoricalClueEvent {
  final String title;
  final String content;
  final String phone;
  final String provider;
  final String unit;

  final SuccessCallback successCallback;

  const AddHistoricalClue(this.title, this.content, this.phone, this.provider,
      this.unit, this.successCallback)
      : super();
}
