part of 'news_topic_bloc.dart';

abstract class NewsTopicEvent extends Equatable {
  const NewsTopicEvent();

  @override
  List<Object> get props => [];
}


class GetListData extends NewsTopicEvent {
  final int pageNo;
  final int pageSize;

  const GetListData(this.pageNo, this.pageSize) : super();

  @override
  List<Object> get props => [pageNo, pageSize];
}

class GetDetailsData extends NewsTopicEvent {
  final String id;

  const GetDetailsData(this.id) : super();

  @override
  List<Object> get props => [id];
}

class NewsTopicInitialed extends NewsTopicEvent {
  const NewsTopicInitialed() : super();
}

class NewsTopicListEvent extends NewsTopicEvent {
  const NewsTopicListEvent() : super();
}
