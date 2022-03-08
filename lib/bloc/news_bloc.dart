import 'package:bloc/bloc.dart';
import 'package:cppcc_app/dto/news/news_entity.dart';
import 'package:cppcc_app/repository/news_repository.dart';
import 'package:equatable/equatable.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;

  NewsBloc(this._newsRepository) : super(NewsState()) {
    on<NewsEvent>((event, emit) {
      // TODO: implement event handler
    });

    //请求获取列表数据
    on<GetNewsListData>((event, emit) async {
      await _newsRepository
          .getNewsList(event.pageNo, event.pageSize, new NewsRecords())
          .then((result) {
        emit(_populateMessageData(result));
      });
    });
  }

  @override
  void onChange(Change<NewsState> change) {
    super.onChange(change);
    print("object");
  }

  _populateMessageData(NewsEntity result) {
    return state.copyWith(result.current, result);
  }
}
