import 'package:cppcc_app/models/proposal.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class ProposalRepository {
  final ApiDataProvider _apiDataProvider;

  ProposalRepository(this._apiDataProvider);

  Future<int> getUnreadCount() {
    return _apiDataProvider.getProposalUnreadCount();
  }

  Future<List<Proposal>> getProposList(
      int page, int pageSize, bool? excellent) async {
    var data =
        await _apiDataProvider.getProposalList(page, pageSize, excellent);
    return data
        .map((e) => Proposal(
            id: e.id,
            title: e.title,
            author: e.authorUserDictText ?? '',
            content: e.content ?? '',
            status: e.status ?? 0,
            statusDictText: e.statusDictText ?? '',
            createTime: DateTime.parse(e.createTime),
            read: e.read ?? false,
            createBy: e.createBy ?? '',
            year: e.year ?? 2022))
        .toList();
  }
}
