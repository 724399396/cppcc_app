import 'package:cppcc_app/dto/base_response.dart';
import 'package:cppcc_app/dto/meeting_response.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class MeetingRepository {
  final ApiDataProvider _apiDataProvider;

  MeetingRepository(this._apiDataProvider);

  Future<MeetingWrapper> getListPage(
      int pageNo, int pageSize, String type) async {
    var response =
        await _apiDataProvider.getMeetingList(pageNo, pageSize, type);
    return response;
  }

  Future<BaseResponse> addMailbox(String type, String userId, String phone,
      String title, String content) async {
    var response =
        await _apiDataProvider.addMailbox(type, userId, phone, title, content);
    return response;
  }
}
