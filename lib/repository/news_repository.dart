import 'package:cppcc_app/dto/news/news_topic_entity.dart';
import 'package:cppcc_app/repository/api_provider.dart';
//资讯
import 'package:cppcc_app/dto/news/news_entity.dart';

class NewsRepository {
  final ApiDataProvider _apiDataProvider;

  NewsRepository(this._apiDataProvider);

  Future<NewsTopicEntity> getNewsTopocList(int pageNo, int pageSize) async {
    var response = await _apiDataProvider.getNewsTopocList(pageNo, pageSize);
    return response;
  }

  Future<NewsEntity> getNewsList(
      int pageNo, int pageSize, NewsRecords newsRecords) async {
    var response =
        await _apiDataProvider.getNewsList(pageNo, pageSize, newsRecords);
    return response;
  }
}
