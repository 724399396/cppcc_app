import 'package:cppcc_app/repository/api_provider.dart';

class NoticeRepository {
  final ApiDataProvider _apiDataProvider;

  NoticeRepository(this._apiDataProvider);

  Future<int> getUnreadCount() {
    return _apiDataProvider.getNoticeUnreadCount();
  }
}
