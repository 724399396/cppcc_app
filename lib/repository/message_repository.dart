import 'package:cppcc_app/repository/api_provider.dart';
import 'package:cppcc_app/dto/message/message_entity.dart';

class MessageRepository {
  final ApiDataProvider _apiDataProvider;

  MessageRepository(this._apiDataProvider);

  Future<MessageEntity> getMessageList(
      int pageNo, int pageSize, String msgCategory) async {
    var response =
        await _apiDataProvider.getMassage(pageNo, pageSize, msgCategory);
    return response;
  }

  Future<MessageRecords> getMessageInfo(String id) async {
    var response = await _apiDataProvider.getMassageInfo(id);
    return response;
  }
}
