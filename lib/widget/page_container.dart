import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/page/home_page.dart';
import 'package:flutter/material.dart';

import 'package:cppcc_app/page/home_news.dart';
import 'package:cppcc_app/page/home_contacts.dart';
import 'package:cppcc_app/page/home_message.dart';
import 'package:cppcc_app/page/home_me.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({Key? key}) : super(key: key);

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int unreadMessageCount = 0;

  @override
  void initState() {
    _tabController = TabController(
        length: notSelectedTabs.length, vsync: this, initialIndex: 0);
    _tabController.addListener(handleTabChange);
    updateUnreadMessageCount(BlocProvider.of<MessageBloc>(context).state);
    super.initState();
  }

  void handleTabChange() {
    if (_tabController.indexIsChanging) return;
    setState(() {});
  }

  void updateUnreadMessageCount(MessageState state) {
    setState(() {
      unreadMessageCount = state.unreadCount.values
          .fold(0, (int value, int element) => value + element);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MessageBloc, MessageState>(
      listenWhen: ((previous, current) =>
          previous.unreadCount != current.unreadCount),
      listener: (context, state) {
        updateUnreadMessageCount(BlocProvider.of<MessageBloc>(context).state);
      },
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 50,
          child: TabBar(
            tabs: List.generate(notSelectedTabs.length, (index) {
              bool selected = index == _tabController.index;
              BottomTab tab =
                  selected ? selectedTabs[index] : notSelectedTabs[index];
              return Tab(
                child: selected
                    ? CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: Image.asset(tab.image).image,
                      )
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset(tab.image),
                              ),
                              Text(tab.text)
                            ],
                          ),
                          tab.text == '消息' && unreadMessageCount > 0
                              ? Positioned(
                                  top: -2,
                                  right: -6,
                                  child: Container(
                                    width: 14,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFfa422a),
                                    ),
                                    child: Text(
                                      unreadMessageCount.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                key: Key(tab.text),
              );
            }).toList(),
            controller: _tabController,
            indicator: const BoxDecoration(),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomePage(),
            HomeNews(),
            HomeContacts(),
            HomeMessage(),
            HomeMe(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
