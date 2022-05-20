import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

typedef DataFetchter<S, D> = List<D> Function(S);
typedef ChildBuilder<D> = Widget Function(D);

class BlocEasyFrefresh<B extends StateStreamableSource<S>,
    S extends WithListFetchState, D> extends StatelessWidget {
  final DataFetchter<S, D> dataFetcher;
  final OnLoadCallback onLoadCallback;
  final OnRefreshCallback onRefreshCallback;
  final ChildBuilder<D> childBuilder;
  final Widget? prefix;

  const BlocEasyFrefresh(this.dataFetcher, this.onLoadCallback,
      this.onRefreshCallback, this.childBuilder,
      {Key? key, this.prefix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(builder: (context, state) {
      var data = dataFetcher(state);
      var refresh = EasyRefresh.custom(
        header: ClassicalHeader(
          refreshText: '下拉刷新',
          refreshReadyText: '释放刷新',
          refreshingText: '加载中',
          refreshedText: '加载完成',
          refreshFailedText: '加载失败',
          noMoreText: '没有更多数据',
          infoText: '更新于 %T',
          textColor: Colors.black,
        ),
        footer: ClassicalFooter(
          loadText: '上拉加载更多',
          loadReadyText: '释放刷新',
          loadingText: '加载中',
          loadedText: '加载完成',
          loadFailedText: '加载失败',
          noMoreText: '没有更多数据',
          infoText: '更新于 %T',
          textColor: Colors.black,
        ),
        onLoad: onLoadCallback,
        onRefresh: onRefreshCallback,
        emptyWidget: data.isEmpty ? const EmptyData() : null,
        slivers: prefix != null
            ? [prefix!, ...data.map((p) => childBuilder(p)).toList()]
            : data.map((p) => childBuilder(p)).toList(),
      );
      return refresh;
    });
  }
}
