import 'package:cppcc_app/dto/mailbox_response.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class MailboxRepository {
  final ApiDataProvider _apiDataProvider;

  MailboxRepository(this._apiDataProvider);

  Future<MailboxResponseWrapper> getListPage(
      int pageNo, int pageSize, String mailboxType) async {
    var response =
        await _apiDataProvider.getMailBoxList(pageNo, pageSize, mailboxType);
    return response;
  }
}
