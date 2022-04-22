part of 'guandu_historical_clue_bloc.dart';

class GuanduHistoricalClueState extends Equatable {
  final ListDataFetchStatus status;
  final List<GuanduHistoricalClue> data;
  final int currentPage;
  final FormStatus? submitStatus;
  const GuanduHistoricalClueState({
    this.status = ListDataFetchStatus.normal,
    this.data = const [],
    this.currentPage = 0,
    this.submitStatus,
  });

  GuanduHistoricalClueState copyWith({
    ListDataFetchStatus? status,
    List<GuanduHistoricalClue>? data,
    int? currentPage,
    FormStatus? submitStatus,
  }) {
    return GuanduHistoricalClueState(
      status: status ?? this.status,
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
      submitStatus: submitStatus ?? this.submitStatus,
    );
  }

  @override
  String toString() {
    return 'GuanduHistoricalClueState(status: $status, data: $data, currentPage: $currentPage, submitStatus: $submitStatus)';
  }

  @override
  List<Object> get props => [status, data, currentPage, submitStatus ?? ''];
}
