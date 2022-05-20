import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:cppcc_app/dto/message_type.dart';
import 'package:cppcc_app/models/message.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/message_list_item.dart';
import 'package:flutter/material.dart';
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
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
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
                    int unreadCount = state.unreadCount[item] ?? 0;
                    return Container(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Text(
                            item.description,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          unreadCount > 0
                              ? Positioned(
                                  top: -2,
                                  right: -16,
                                  child: Container(
                                    width: 16,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFfa472f),
                                    ),
                                    child: Text(
                                      unreadCount.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
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
      },
    );
  }
}

// 列表信息
class MessageContentPage extends StatelessWidget {
  final MessageType type;
  const MessageContentPage({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MessageBloc>(context).add(MessageFirstFetch(type));
    return BlocEasyFrefresh<MessageBloc, MessageState, Message>(
        (state) => (state.messages[type] ?? [])
            .where((element) => !["提案办理通知", "社情民意通知"].contains(element.title))
            .toList(), () async {
      BlocProvider.of<MessageBloc>(context).add(MessageLoadMore(type));
    }, () async {
      BlocProvider.of<MessageBloc>(context).add(MessageRefresh(type));
    }, (p) => MessageListItem(p));
  }
}
