import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:cppcc_app/dto/message_type.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/message_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMessage extends StatefulWidget {
  const HomeMessage({Key? key}) : super(key: key);

  @override
  _HomeMessageState createState() => _HomeMessageState();
}

class _HomeMessageState extends State<HomeMessage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<MessageType> _tabs;
  late TabController _tabController;

  @override
  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabs = [MessageType.notice, MessageType.businessCard, MessageType.system];
    _tabController =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("消息"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Theme(
            data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              unselectedLabelColor: Colors.white,
              indicatorColor: const Color(0xffffffff),
              indicatorWeight: 1,
              tabs: _tabs.map((item) {
                return Container(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    item.description,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((item) {
          return MessageContentPage(type: item);
        }).toList(),
      ),
    );
  }
}

// 列表信息
class MessageContentPage extends StatelessWidget {
  final MessageType type;
  const MessageContentPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EasyRefreshController _easyRefreshController =
        EasyRefreshController();
    BlocProvider.of<MessageBloc>(context).add(MessageFirstFetch(type));
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (previous, current) {
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
        // TODO
        var data = (state.messages[type] ?? [])
            .where((element) => !["提案办理通知", "社情民意通知"].contains(element.title))
            .toList();
        return EasyRefresh.custom(
          controller: _easyRefreshController,
          enableControlFinishRefresh: true,
          enableControlFinishLoad: true,
          header: easyRefreshHeader,
          footer: easyRefreshFooter,
          onLoad: () async {
            BlocProvider.of<MessageBloc>(context).add(MessageLoadMore(type));
          },
          onRefresh: () async {
            BlocProvider.of<MessageBloc>(context).add(MessageRefresh(type));
          },
          emptyWidget: data.isEmpty ? const EmptyData() : null,
          slivers: data.map((p) => MessageListItem(p)).toList(),
        );
      },
    );
  }
}
