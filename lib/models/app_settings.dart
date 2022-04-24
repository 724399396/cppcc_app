import 'package:cppcc_app/repository/local_data_provider.dart';

import 'package:cppcc_app/dto/login_response.dart';

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

const int pageSize = 10;

///根据字典类型获取字典列表
///DictService().getDictItemByCode("msg_category").then((datas) => print(datas.length));
// TODO delete
class DictService {
  /// 	领导信箱类型
  String mailboxType = "mailbox_type";

  /// 	通告类型
  String msgCategory = "msg_category";

  var localDataProvider = LocalDataProvider();

  Future<List<DictItem>> getDictItemByCode(String dictCode) async {
    // TODO
    await localDataProvider.init();
    return [];

    // String? dataStr = localDataProvider.dictData();
    // if (dataStr != null) {
    //   DictItemEntity dictItemEntity = DictItemEntity.fromJson(
    //       convert.jsonDecode(dataStr) as Map<String, dynamic>);
    //   return dictItemEntity.dictData
    //       .where((item) => item.dictCode == dictCode)
    //       .toList();
    // }
    // return [];
  }
}
