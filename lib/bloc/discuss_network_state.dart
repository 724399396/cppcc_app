part of 'discuss_network_bloc.dart';

class DiscussNetworkState extends Equatable {
  final int pageNo;
  final int pageSize;
  final int total;
  final List<DiscussNetworkResponse> listDatas;

  const DiscussNetworkState({
    this.pageNo = 1,
    this.pageSize = 10,
    this.total = 0,
    this.listDatas = const [],
  });

  DiscussNetworkState copyWith(
    int pageNo,
    DiscussNetworkResponseWrapper result,
  ) {
    return DiscussNetworkState(
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
