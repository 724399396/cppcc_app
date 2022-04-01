part of 'historical_clue_bloc.dart';

typedef SuccessCallback = void Function();

typedef FailCallback = void Function();

abstract class HistoricalClueEvent extends Equatable {
  final SuccessCallback? successCallback;
  final FailCallback? failCallback;

  const HistoricalClueEvent(this.successCallback, this.failCallback);

  @override
  List<Object> get props => [];
}

class GetHistoricalClueListData extends HistoricalClueEvent {
  final int pageNo;
  final int pageSize;

  const GetHistoricalClueListData(this.pageNo, this.pageSize)
      : super(null, null);

  @override
  List<Object> get props => [pageNo, pageSize];
}

class AddHistoricalClue extends HistoricalClueEvent {
  final String? type;
  final String title;
  final String? content;
  final String? phone;
  final String? provider;
  final String? unit;

  const AddHistoricalClue(this.type, this.title, this.content, this.phone,
      this.provider, this.unit, successCallback, failCallback)
      : super(successCallback, failCallback);

  @override
  List<Object> get props => [type!, title, content!, phone!, provider!, unit!];
}
