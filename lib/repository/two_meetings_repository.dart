import 'package:cppcc_app/models/two_meetings.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class TwoMeetingsRepository {
  final ApiDataProvider _apiDataProvider;

  TwoMeetingsRepository(this._apiDataProvider);

  Future<List<TwoMeetings>> getList(int pageNo, int pageSize) async {
    var response = await _apiDataProvider.getTwoMeetingsList(pageNo, pageSize);
    return response.records
        .map(
          (e) => TwoMeetings(
            id: e.id,
            title: e.title,
            content: e.content,
            cover: e.cover,
            createAt: e.createAt ?? '',
            hits: e.hits ?? 0,
          ),
        )
        .toList();
  }
}
