import 'package:cppcc_app/models/meeting.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class MeetingRepository {
  final ApiDataProvider _apiDataProvider;

  MeetingRepository(this._apiDataProvider);

  Future<int> getUnreadCount() {
    return _apiDataProvider.getMeetingUnreadCount();
  }

  Future<List<Meeting>> getList(int pageNo, int pageSize, String type) async {
    var response =
        await _apiDataProvider.getMeetingList(pageNo, pageSize, type);
    return response.records
        .map(
          (e) => Meeting(
              id: e.id,
              title: e.title ?? '',
              address: e.address ?? '',
              beginDate: e.beginDate ?? '',
              startTime: e.startTime ?? '',
              endTime: e.endTime ?? '',
              content: e.content ?? '',
              status: e.status ?? 0,
              statusDictText: e.statusDictText ?? '',
              type: e.type ?? 1,
              typeDicttext: e.typeDicttext ?? '',
              createBy: e.createBy ?? '',
              signQrcode: e.signQrcode,
              userRecords: e.userRecords
                      ?.map<MeetingActiveRecord>((r) => MeetingActiveRecord(
                          userIdDictText: r.userIdDictText ?? ''))
                      .toList() ??
                  []),
        )
        .toList();
  }
}
