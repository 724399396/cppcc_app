part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class GetNewsListData extends NewsEvent {
  final int pageNo;
  final int pageSize;

  const GetNewsListData(this.pageNo, this.pageSize) : super();

  @override
  List<Object> get props => [pageNo, pageSize];
}

class GetDetailsData extends NewsEvent {
  final String id;

  const GetDetailsData(this.id) : super();

  @override
  List<Object> get props => [id];
}

class NewsInitialed extends NewsEvent {
  const NewsInitialed() : super();
}

class NewsListEvent extends NewsEvent {
  const NewsListEvent() : super();
}
