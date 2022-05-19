import 'package:cppcc_app/dto/base_response.dart';
import 'package:cppcc_app/dto/mailbox_request.dart';
import 'package:cppcc_app/dto/mailbox_response.dart';
import 'package:cppcc_app/models/mail.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class MailboxRepository {
  final ApiDataProvider _apiDataProvider;

  MailboxRepository(this._apiDataProvider);

  Future<List<Mail>> getListPage(
      int pageNo, int pageSize, String mailboxType) async {
    var response =
        await _apiDataProvider.getMailBoxList(pageNo, pageSize, mailboxType);
    return response.map(_buildMail).toList();
  }

  Future<BaseResponse> addMailbox(AddMailRequest request) async {
    var response = await _apiDataProvider.addMailbox(request);
    return response;
  }

  Future<int> getUnreadCount() {
    return _apiDataProvider.getMailboxUnreadCount();
  }

  Future<Mail> getMailDetail(String id) async {
    var data = await _apiDataProvider.getMailDetail(id);
    return _buildMail(data);
  }

  Mail _buildMail(MailboxResponse e) {
    return Mail(
      id: e.id,
      title: e.title,
      content: e.content ?? '',
      createTime: e.createTime,
      read: e.read ?? false,
      type: e.type ?? 0,
      typeDictText: e.typeDictText ?? '',
      userId: e.userId ?? '',
      userRealname: e.userRealname ?? '',
      category: e.category ?? 0,
      createBy: e.createBy,
      phone: e.phone ?? '',
      handleTime: e.handleTime != null ? DateTime.parse(e.handleTime!) : null,
      handleWorkunit: e.handleWorkunit ?? '',
      replyMessage: e.replyMessage ?? '',
      appendix: e.appendix?.split(",")
    );
  }
}
