import 'package:bloc/bloc.dart';
import 'package:cppcc_app/dto/news/news_entity.dart';
import 'package:cppcc_app/dto/news/news_topic_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:cppcc_app/repository/news_repository.dart';

part 'news_topic_event.dart';
part 'news_topic_state.dart';

class NewsTopicBloc extends Bloc<NewsTopicEvent, NewsTopicState> {
  final NewsRepository _newsRepository;

  NewsTopicBloc(this._newsRepository) : super(NewsTopicState()) {
    on<NewsTopicEvent>((event, emit) {
      // TODO: implement event handler
    });

    //请求获取列表数据
    on<GetListData>((event, emit) async {
      await _newsRepository
          .getNewsTopocList(event.pageNo, event.pageSize)
          .then((result) {
        emit(_populateMessageData(result));
      });
    });
  }

  @override
  void onChange(Change<NewsTopicState> change) {
    super.onChange(change);
    print("object");
  }

  _populateMessageData(NewsTopicEntity result) {
    return state.copyWith(result.current, result);
  }
}
