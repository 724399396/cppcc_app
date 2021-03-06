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

const String baseUrl = 'cppcc.lingrit.com/cppcc-boot';
// const String baseUrl = '172.10.1.181:10030/cppcc-boot';
