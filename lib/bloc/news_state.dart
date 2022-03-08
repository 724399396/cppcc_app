part of 'news_bloc.dart';

class NewsState extends Equatable {
  final int pageNo;
  final int pageSize;
  final int total;
  final List<NewsRecords> listDatas;

  // final SuccessCallback? successCallback;

  NewsState({
    this.pageNo = 1,
    this.pageSize = 10,
    this.total = 0,
    this.listDatas = const [],
  });

  NewsState copyWith(
    int pageNo,
    NewsEntity result,
  ) {
    print("pageNo===========================" + pageNo.toString());
    return NewsState(
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
