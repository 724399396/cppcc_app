import 'package:cppcc_app/dto/base_response.dart';
import 'package:cppcc_app/models/mail.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class MailboxRepository {
  final ApiDataProvider _apiDataProvider;

  MailboxRepository(this._apiDataProvider);

  Future<List<Mail>> getListPage(
      int pageNo, int pageSize, String mailboxType) async {
    var response =
        await _apiDataProvider.getMailBoxList(pageNo, pageSize, mailboxType);
    return response.records
        .map((e) => Mail(
              id: e.id,
              title: e.title,
              content: e.content ?? '',
              createTime: e.createTime,
              read: e.read ?? true,
              type: e.type ?? 0,
              typeDictText: e.typeDictText ?? '',
              userId: e.userId ?? '',
              userRealname: e.userRealname ?? '',
              category: e.category ?? 0,
              createBy: e.createBy,
              phone: e.phone ?? '',
            ))
        .toList();
  }

  Future<BaseResponse> addMailbox(String type, String userId, String phone,
      String title, String content) async {
    var response =
        await _apiDataProvider.addMailbox(type, userId, phone, title, content);
    return response;
  }

  Future<int> getUnreadCount() {
    return _apiDataProvider.getMailboxUnreadCount();
  }
}
