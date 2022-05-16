import 'package:cppcc_app/dto/opinion_request.dart';
import 'package:cppcc_app/models/opinions.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class OpinionRepository {
  final ApiDataProvider _apiDataProvider;

  OpinionRepository(this._apiDataProvider);

  Future<int> getUnreadCount() {
    return _apiDataProvider.getOpinionUnreadCount();
  }

  Future<List<Opinion>> getOpnionsList(
      int page, int pageSize, List<int> status) {
    return _apiDataProvider.getOpinionsList(page, pageSize, status).then(
        (res) => res
            .map((e) => Opinion(
                id: e.id,
                title: e.title,
                typeDictText: e.typeDictText ?? '',
                authorId: e.authorUser ?? '',
                author: e.authorUserDictText ?? '',
                content: e.content ?? '',
                status: e.status ?? 0,
                statusDictText: e.statusDictText ?? '',
                createTime: DateTime.parse(e.createTime),
                read: e.read ?? false,
                createBy: e.createBy))
            .toList());
  }

  Future addOpinion(OpinionAddRequest opinion) {
    return _apiDataProvider.addOpinion(opinion);
  }

  Future getOpinionDetail(id) {
    return _apiDataProvider.getOpinionDetail(id);
  }

  Future<List<OpinionProgress>> getOpinionProgress(String id) async {
    var data = await _apiDataProvider.getOpinionProgress(id);
    return data
        .map((e) => OpinionProgress(
            content: e.content
                .map((ie) => KeyValue(key: ie.title, value: ie.value))
                .toList(),
            type: e.type,
            typeDictText: e.typeDictText))
        .toList();
  }
}
