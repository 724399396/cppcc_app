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
    return response
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
              read: e.read),
        )
        .toList();
  }

  Future<MeetingDetail> getMeetingDetail(String id) async {
    var detail = await _apiDataProvider.getMeetingDetail(id);
    return MeetingDetail(
      id: detail.id,
      title: detail.title ?? '',
      address: detail.address ?? '',
      beginDate: detail.beginDate ?? '',
      startTime: detail.startTime ?? '',
      endTime: detail.endTime ?? '',
      content: detail.content ?? '',
      status: detail.status ?? 0,
      statusDictText: detail.statusDictText ?? '',
      type: detail.type ?? 1,
      typeDicttext: detail.typeDicttext ?? '',
      createBy: detail.createBy ?? '',
      signQrcode: detail.signQrcode ?? '',
      userRecords: detail.userRecords
              ?.map<MeetingActiveRecord>((r) => MeetingActiveRecord(
                    userId: r.userId ?? '',
                    userIdDictText: r.userIdDictText ?? '',
                    status: r.status ?? 0,
                    read: r.read ?? false,
                  ))
              .toList() ??
          [],
      broadcasts: detail.broadcastData
              ?.map((b) => Broadcast(
                  title: b.title ?? '',
                  content: b.content ?? '',
                  createTime: b.createTime ?? ''))
              .toList() ??
          [],
    );
  }

  Future applyLeaveMeeting(String meetingId, String userId) {
    return _apiDataProvider.applyLeaveMeeting(meetingId, userId);
  }
}
