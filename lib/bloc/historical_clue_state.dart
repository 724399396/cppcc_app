part of 'historical_clue_bloc.dart';

class HistoricalClueState extends Equatable {
  final int pageNo;
  final int pageSize;
  final int total;
  final List<HistoricalClueResponse> listDatas;

  const HistoricalClueState({
    this.pageNo = 1,
    this.pageSize = 10,
    this.total = 0,
    this.listDatas = const [],
  });

  HistoricalClueState copyWith(
    int pageNo,
    HistoricalClueWrapper result,
  ) {
    return HistoricalClueState(
      pageNo: pageNo,
      pageSize: result.size,
      total: result.total,
      listDatas: result.records,
    );
  }

  @override
  List<Object> get props {
    return [
      pageNo,
      pageSize,
      total,
      listDatas,
    ];
  }
}
