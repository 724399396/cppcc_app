import 'package:cppcc_app/repository/api_provider.dart';

class ProposalRepository {
  final ApiDataProvider _apiDataProvider;

  ProposalRepository(this._apiDataProvider);

  Future<int> getUnreadCount() {
    return _apiDataProvider.getProposalUnreadCount();
  }
}
