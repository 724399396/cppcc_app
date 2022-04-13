import 'package:cppcc_app/models/opinions.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class OpinionRepository {
  final ApiDataProvider _apiDataProvider;

  OpinionRepository(this._apiDataProvider);

  Future<int> getUnreadCount() {
    return _apiDataProvider.getUnreadCount();
  }

  Future<List<Opinion>> getOpnionsList(
      int page, int pageSize, List<int> status) {
    return _apiDataProvider.getOpinionsList(page, pageSize, status).then(
        (res) => res
            .map((e) => Opinion(
                id: e.id,
                title: e.title,
                typeDictText: e.typeDictText ?? '',
                author: e.authorUserDictText ?? '',
                content: e.content ?? '',
                status: e.status ?? 0,
                statusDictText: e.statusDictText ?? '',
                createTime: DateTime.parse(e.createTime),
                read: e.read))
            .toList());
  }
}
