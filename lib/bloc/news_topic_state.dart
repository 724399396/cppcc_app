part of 'news_topic_bloc.dart';

class NewsTopicState extends Equatable {
  final int pageNo;
  final int pageSize;
  final int total;
  final List<NewsTopicRecords> listDatas;

  // final SuccessCallback? successCallback;

  NewsTopicState({
    this.pageNo = 1,
    this.pageSize = 10,
    this.total = 0,
    this.listDatas = const [],
  });

  NewsTopicState copyWith(
    int pageNo,
    NewsTopicEntity result,
  ) {
    print("pageNo===========================" + pageNo.toString());
    return NewsTopicState(
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
