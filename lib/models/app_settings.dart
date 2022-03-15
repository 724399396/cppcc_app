import 'dart:convert' as convert;

import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';

import '../dto/login_response.dart';

class BottomTab {
  late String image;
  late String text;

  BottomTab({required this.image, required this.text});
}

final List<BottomTab> notSelectedTabs = [
  BottomTab(
    image: 'assets/icons/ic_zhuye_normal.png',
    text: '首页',
  ),
  BottomTab(
    image: 'assets/icons/ic_zix_normal.png',
    text: '资讯',
  ),
  BottomTab(
    image: 'assets/icons/ic_tongxl_normal.png',
    text: '通讯录',
  ),
  BottomTab(
    image: 'assets/icons/ic_xiaoxi_normal.png',
    text: '消息',
  ),
  BottomTab(
    image: 'assets/icons/ic_wode_normal.png',
    text: '我的',
  ),
];

final List<BottomTab> selectedTabs = [
  BottomTab(
    image: 'assets/icons/ic_zhuye_selected.png',
    text: '首页',
  ),
  BottomTab(
    image: 'assets/icons/ic_zix_selected.png',
    text: '资讯',
  ),
  BottomTab(
    image: 'assets/icons/ic_tongxl_selected.png',
    text: '通讯录',
  ),
  BottomTab(
    image: 'assets/icons/ic_xiaoxi_selected.png',
    text: '消息',
  ),
  BottomTab(
    image: 'assets/icons/ic_wode_selected.png',
    text: '我的',
  ),
];

class HomeTab {
  final String image;
  final String text;
  final String path;

  HomeTab({required this.image, required this.text, required this.path});
}

final List<HomeTab> homeTabs = [
  HomeTab(
      image: 'assets/icons/ic_lvzhidangan.png',
      text: '履职档案',
      path: Routes.performanceFilePage),
  HomeTab(
      image: 'assets/icons/ic_sheqingmyi.png',
      text: '社情民意',
      path: Routes.socialOpinionsPage),
  HomeTab(
      image: 'assets/icons/ic_tianbanli.png',
      text: '提案管理',
      path: Routes.proposalManagePage),
  HomeTab(
      image: 'assets/icons/ic_huiyihuod.png',
      text: '会议活动',
      path: Routes.meetingActivitiesPage),
  HomeTab(
      image: 'assets/icons/ic_wenjiangonggao.png',
      text: '通知公告',
      path: Routes.noticePage),
  HomeTab(
      image: 'assets/icons/ic_wangluoyiz.png',
      text: '网络议政',
      path: Routes.networkPoliticalPage),
  HomeTab(
      image: 'assets/icons/ic_weiyuanxuexi.png',
      text: '委员学习',
      path: Routes.memberStudyPage),
  HomeTab(
      image: 'assets/icons/ic_lingdaoyoux.png',
      text: '领导信箱',
      path: Routes.leaderMailboxPage),
];

const int pageSize = 10;

///根据字典类型获取字典列表
///DictService().getDictItemByCode("msg_category").then((datas) => print(datas.length));
class DictService {
  /// 	委员学习专题
  String learningCategories = "learning_categories";

  /// 	领导信箱类型
  String mailboxType = "mailbox_type";

  /// 	网络议政
  String discussNetworkStatus = "discuss_network_status";

  /// 	会议活动
  String meetingActivityType = "meeting_activity_type";

  /// 	社情民意
  String opinionType = "opinion_type";
  
  /// 	通告类型
  String msgCategory = "msg_category";
  
  /// 	提案类型
  String proposalType = "proposal_type";

  var localDataProvider = LocalDataProvider();

  Future<List<DictItem>> getDictItemByCode(String dictCode) async {
    await localDataProvider.init();

    String? dataStr = localDataProvider.dictData();
    if (dataStr != null) {
      DictItemEntity dictItemEntity = DictItemEntity.fromJson(
          convert.jsonDecode(dataStr) as Map<String, dynamic>);
      return dictItemEntity.dictData
          .where((item) => item.dictCode == dictCode)
          .toList();
    }
    return [];
  }
}
