import 'package:cppcc_app/dto/discuss_network_request.dart';
import 'package:cppcc_app/dto/discuss_network_response.dart';
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
    return response.map((e) => _buildDiscussNetwork(e)).toList();
  }

  Future<DiscussNetwork> getDiscussNetworkDetail(String id) async {
    var data = await _apiDataProvider.getDiscussNetworkDetail(id);
    return _buildDiscussNetwork(data);
  }

  Future userLike(String id, int type) {
    return _apiDataProvider.userLikeDiscussNetwork(id, type);
  }

  Future sendMsg(DiscussMessageSendRequest request) {
    return _apiDataProvider.dicusssNetworkMsgSend(request);
  }

  DiscussNetwork _buildDiscussNetwork(DiscussNetworkResponse e) {
    return DiscussNetwork(
      id: e.id,
      title: e.title,
      description: e.description ?? '',
      status: e.status ?? 0,
      statusDictText: e.statusDictText ?? '',
      beginDate: e.beginDate ?? '',
      endDate: e.endDate ?? '',
      createBy: e.createBy,
      createTime: e.createTime,
      updateBy: e.updateBy ?? '',
      updateTime: e.updateTime ?? '',
      cover: e.cover,
      userRecords: e.users
              ?.map<PartUser>((u) => PartUser(userRealname: u.realname ?? ''))
              .toList() ??
          [],
      discussMessages: e.discussMessages
              ?.map<DiscussMessage>((d) => DiscussMessage(
                    id: d.id,
                    message: d.message ?? '',
                    ownerName: d.ownerName ?? '',
                    ownerAvatar: d.ownerAvatar,
                    thumbUpCount: d.thumbUpCount ?? 0,
                    thumbUpStatus: d.thumbUpStatus ?? false,
                    createTime: d.createTime ?? '',
                  ))
              .toList() ??
          [],
      discussFiles: e.discussFiles
              ?.map((e) => DiscussFile(
                  id: e.id,
                  title: e.title,
                  content: e.content,
                  createTime: e.createTime != null
                      ? DateTime.parse(e.createTime!)
                      : DateTime.now(),
                  authorRealname: e.authorRealname ?? ''))
              .toList() ??
          [],
      read: e.read ?? true,
      thumbUpCount: e.thumbUpCount ?? 0,
      thumbUpStatus: e.thumbUpStatus ?? false,
      commentCount: e.commentCount ?? 0,
    );
  }
}
