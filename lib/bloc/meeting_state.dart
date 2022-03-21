part of 'meeting_bloc.dart';

class MeetingState extends Equatable {
  final int pageNo;
  final int pageSize;
  final int total;
  final List<MeetingResponse> listDatas;

  const MeetingState({
    this.pageNo = 1,
    this.pageSize = 10,
    this.total = 0,
    this.listDatas = const [],
  });

  MeetingState copyWith(
    int pageNo,
    MeetingWrapper result,
  ) {
    return MeetingState(
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
