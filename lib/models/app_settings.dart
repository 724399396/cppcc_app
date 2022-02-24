import 'package:equatable/equatable.dart';

class BottomTab {
  late String image;
  late String text;

  BottomTab({required this.image, required this.text});
}

class DictTitleValue extends Equatable {
  final String title;
  final String value;
  const DictTitleValue({
    this.title = '',
    this.value = '',
  });

  DictTitleValue copyWith({
    String? title,
    String? value,
  }) {
    return DictTitleValue(
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, value];
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
