import 'package:cppcc_app/dto/opinion_response.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class OpinionRepository {
  final ApiDataProvider _apiDataProvider;

  OpinionRepository(this._apiDataProvider);

  Future<int> getUnreadCount() {
    return _apiDataProvider.getUnreadCount();
  }

  Future<OpinionResponseWrapper> getOpnionsList(
      int page, int pageSize, int status) {
    return _apiDataProvider.getOpinionsList(page, pageSize, status);
  }
}
