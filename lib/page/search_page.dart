import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/posts_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// TODO replace real search
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _easyRefreshController = EasyRefreshController();
    final keyword = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //修改颜色
        ),
        title: const Text(
          "搜索结果",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xfff27f56),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          children: [
            GeneralSearch(
              AppColors.greyTextColor,
              ((context, keyword) => {}),
              initValue: keyword,
            ),
            Expanded(
                child: BlocConsumer<PostsBloc, PostsState>(
              buildWhen: (previous, current) =>
                  previous.news != current.news ||
                  previous.fileAnnments != current.fileAnnments ||
                  previous.status != current.status,
              listenWhen: (previous, current) =>
                  previous.news != current.news ||
                  previous.fileAnnments != current.fileAnnments ||
                  previous.status != current.status,
              listener: (previous, current) {
                // easy conller
                switch (current.status) {
                  case ListDataFetchStatus.normal:
                    _easyRefreshController.finishRefresh(success: true);
                    _easyRefreshController.finishLoad(success: true);
                    break;
                  case ListDataFetchStatus.refresh:
                    break;
                  case ListDataFetchStatus.loadMore:
                    break;
                  case ListDataFetchStatus.failure:
                    _easyRefreshController.finishRefresh(success: false);
                    _easyRefreshController.finishLoad(success: false);
                    break;
                }
              },
              builder: (context, state) => EasyRefresh.custom(
                controller: _easyRefreshController,
                enableControlFinishRefresh: true,
                enableControlFinishLoad: true,
                header: easyRefreshHeader,
                footer: easyRefreshFooter,
                onLoad: () async {
                  BlocProvider.of<PostsBloc>(context).add(HomePostLoadMore());
                },
                onRefresh: () async {
                  BlocProvider.of<PostsBloc>(context).add(HomePostRefresh());
                },
                emptyWidget: (state.news + state.fileAnnments).isEmpty
                    ? const Center(child: Text('暂无数据'))
                    : null,
                slivers: (state.news + state.fileAnnments)
                    .map((p) => PostsItem(p))
                    .toList(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
