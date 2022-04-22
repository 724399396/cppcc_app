import 'package:cppcc_app/bloc/guandu_historical_clue_bloc.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/historical_clue_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class GuanduHistoricalClueListPage extends StatelessWidget {
  const GuanduHistoricalClueListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<GuanduHistoricalClueBloc>(context)
        .add(GuanduHistoricalClueFirstFetch());
    var _easyRefreshController = EasyRefreshController();
    return Scaffold(
      appBar: AppBar(title: const Text('史料征集')),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: Stack(
        children: [
          FloatingActionButton.extended(
            heroTag: 'mine',
            icon: const Icon(Icons.my_library_books_outlined),
            backgroundColor: const Color(0xfff27f56),
            foregroundColor: Colors.white,
            label: const Text("我的"),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(Routes.guanduHistoricalClueMePage);
            },
          ),
          Container(
              margin: const EdgeInsets.only(top: 52, bottom: 5),
              child: FloatingActionButton.extended(
                heroTag: 'add',
                icon: const Icon(Icons.add),
                backgroundColor: const Color(0xfff33333),
                foregroundColor: Colors.white,
                label: const Text("新增"),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.gdHistoricalAddPage);
                },
              )),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(children: [
          GeneralSearch(AppColors.greyTextColor, ((context, keyword) => {})),
          Expanded(
              child: SafeArea(
            child: BlocConsumer<GuanduHistoricalClueBloc,
                GuanduHistoricalClueState>(
              buildWhen: (previous, current) =>
                  previous.data != current.data ||
                  previous.status != current.status,
              listenWhen: (previous, current) =>
                  previous.data != current.data ||
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
              builder: (context, state) {
                var data = state.data;
                return EasyRefresh.custom(
                  controller: _easyRefreshController,
                  enableControlFinishRefresh: true,
                  enableControlFinishLoad: true,
                  header: easyRefreshHeader,
                  footer: easyRefreshFooter,
                  onLoad: () async {
                    BlocProvider.of<GuanduHistoricalClueBloc>(context)
                        .add(GuanduHistoricalClueLoadMore());
                  },
                  onRefresh: () async {
                    BlocProvider.of<GuanduHistoricalClueBloc>(context)
                        .add(GuanduHistoricalClueRefresh());
                  },
                  emptyWidget: data.isEmpty ? const EmptyData() : null,
                  slivers: data.map((p) => HistoricalClueItem(p)).toList(),
                );
              },
            ),
          )),
        ]),
      ),
    );
  }
}
