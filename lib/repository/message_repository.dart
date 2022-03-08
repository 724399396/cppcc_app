import 'package:cppcc_app/repository/api_provider.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';
import 'package:cppcc_app/dto/message/message_entity.dart';

class MessageRepository {
  final LocalDataProvider _localDataProvider;
  final ApiDataProvider _apiDataProvider;

  MessageRepository(this._localDataProvider, this._apiDataProvider);

  Future<MessageEntity> getMessageList(int pageNo, int pageSize) async {
    var response = await _apiDataProvider.getMassage(pageNo, pageSize);
    return response;
  }

  Future<MessageRecords> getMessageInfo(String id) async {
    var response = await _apiDataProvider.getMassageInfo(id);
    return response;
  }
}
