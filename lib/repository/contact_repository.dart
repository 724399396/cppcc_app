import 'package:cppcc_app/models/contact.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class ContactRepository {
  final ApiDataProvider _apiDataProvider;

  ContactRepository(this._apiDataProvider);

  Future<List<Contact>> getAllContact() async {
    var response = await _apiDataProvider.getAllContact();
    return response
        .map(
          (e) => Contact(
            company: e.company ?? '',
            postDictText: e.postDictText ?? '',
            phone: e.phone ?? '',
            realname: e.realname,
            avatar: e.avatar,
            username: e.username,
          ),
        )
        .toList();
  }
}
