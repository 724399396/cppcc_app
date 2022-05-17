import 'package:cppcc_app/models/discuss_network.dart';
import 'package:cppcc_app/repository/api_provider.dart';

class DiscussNetworkRepository {
  final ApiDataProvider _apiDataProvider;

  DiscussNetworkRepository(this._apiDataProvider);

  Future<int> getUnreadCount() {
    return _apiDataProvider.getDiscussNetworkUnreadCount();
  }

  Future<List<DiscussNetwork>> getListPage(
      int pageNo, int pageSize, List<int> status) async {
    var response =
        await _apiDataProvider.getDiscussNetworkList(pageNo, pageSize, status);
    return response
        .map((e) => DiscussNetwork(
              id: e.id,
              title: e.title,
              description: e.description ?? '',
              discussMsgs: e.discussMsgs ?? '',
              status: e.status ?? 0,
              statusDictText: e.statusDictText ?? '',
              praiseCount: e.praiseCount ?? 0,
              beginDate: e.beginDate ?? '',
              endDate: e.endDate ?? '',
              createBy: e.createBy,
              createTime: e.createTime,
              updateBy: e.updateBy ?? '',
              updateTime: e.updateTime ?? '',
              cover: e.cover,
              userRecords: e.users
                      ?.map<PartUser>(
                          (u) => PartUser(userRealname: u.realname ?? ''))
                      .toList() ??
                  [],
              discussMessages: e.discussMessages
                      ?.map<DiscussMessage>((d) => DiscussMessage(
                            id: d.id,
                            message: d.message ?? '',
                            ownerName: d.ownerName ?? '',
                            ownerAvatar: d.ownerAvatar,
                            praiseCount: d.praiseCount ?? 0,
                            createTime: d.createTime ?? '',
                          ))
                      .toList() ??
                  [],
              read: e.read ?? true,
              thumbUpCount: e.thumbUpCount ?? 0,
              thumbUpStatus: e.thumbUpStatus ?? false,
              commentCount: e.commentCount ?? 0,
            ))
        .toList();
  }

  Future getDiscussNetworkDetail(String id) {
    return _apiDataProvider.getDiscussNetworkDetail(id);
  }

  Future userLike(String id, int type) {
    return _apiDataProvider.userLikeDiscussNetwork(id, type);
  }
}
