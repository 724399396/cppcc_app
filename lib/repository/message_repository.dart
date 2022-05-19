import 'package:cppcc_app/dto/message_type.dart';
import 'package:cppcc_app/models/message.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class MessageRepository {
  final ApiDataProvider _apiDataProvider;

  MessageRepository(this._apiDataProvider);

  Future<List<Message>> getSystemList(
      int pageNo, int pageSize, MessageType type) async {
    var response =
        await _apiDataProvider.getSystemMessageList(pageNo, pageSize, type);
    return response
        .map((e) => Message(
            id: e.id,
            title: e.titile,
            msgContent: e.msgContent ?? '',
            sendTime: e.sendTime ?? '',
            read: e.read ?? false,
            type: convertToMessageTypeFromSystemCode(e.msgCategory),
            sendUserId: null))
        .toList();
  }

  Future<List<Message>> getBusinessCardList(int pageNo, int pageSize) async {
    var response =
        await _apiDataProvider.getBusinessCardMessageList(pageNo, pageSize);
    return response
        .map((e) => Message(
            id: e.id,
            title: "名片推荐(${e.sendUserDictText})",
            msgContent: e.message,
            sendTime: e.createTime,
            read: e.read ?? false,
            sendUserId: e.sendUser,
            type: MessageType.businessCard))
        .toList();
  }

  Future<int> getUnreadCount(MessageType type) {
    switch (type) {
      case MessageType.notice:
        return _apiDataProvider.getAnnouncementUnreadCount(type);
      case MessageType.businessCard:
        return _apiDataProvider.getBusinessCardUnreadCount();
      case MessageType.system:
        return _apiDataProvider.getAnnouncementUnreadCount(type);
    }
  }

  Future readMessage(Message message) {
    switch (message.type) {
      case MessageType.notice:
        return _apiDataProvider.readAnnouncementMessage(message.id);
      case MessageType.businessCard:
        return _apiDataProvider.getBusinessCardDetail(message.id);
      case MessageType.system:
        return _apiDataProvider.readAnnouncementMessage(message.id);
    }
  }
}
