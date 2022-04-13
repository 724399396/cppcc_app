import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

final ClassicalHeader easyRefreshHeader = ClassicalHeader(
  refreshText: '下拉刷新',
  refreshReadyText: '释放刷新',
  refreshingText: '加载中',
  refreshedText: '加载完成',
  refreshFailedText: '加载失败',
  noMoreText: '没有更多数据',
  infoText: '更新于 %T',
  textColor: Colors.black,
);

final ClassicalFooter easyRefreshFooter = ClassicalFooter(
  loadText: '上拉加载更多',
  loadReadyText: '释放刷新',
  loadingText: '加载中',
  loadedText: '加载完成',
  loadFailedText: '加载失败',
  noMoreText: '没有更多数据',
  infoText: '更新于 %T',
  textColor: Colors.black,
);
