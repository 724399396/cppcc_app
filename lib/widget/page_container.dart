import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/page/home_page.dart';
import 'package:flutter/material.dart';

import 'package:cppcc_app/page/home_news.dart';
import 'package:cppcc_app/page/home_contacts.dart';
import 'package:cppcc_app/page/home_message.dart';
import 'package:cppcc_app/page/home_me.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({Key? key}) : super(key: key);

  @override
  _PageContainerState createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
        length: notSelectedTabs.length, vsync: this, initialIndex: 0);
    _tabController.addListener(handleTabChange);
    super.initState();
  }

  void handleTabChange() {
    if (_tabController.indexIsChanging) return;
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 50,
        child: TabBar(
          tabs: List.generate(notSelectedTabs.length, (index) {
            bool selected = index == _tabController.index;
            BottomTab tab =
                selected ? selectedTabs[index] : notSelectedTabs[index];
            return Tab(
              child: selected
                  ? SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset(tab.image),
                    )
                  : Column(
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
              key: Key(tab.text),
            );
          }).toList(),
          controller: _tabController,
          indicator: const BoxDecoration(),
        ),
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const HomePage(),
          const HomeNews(),
          const HomeContacts(),
          const HomeMessage(),
          HomeMe(),
        ],
        controller: _tabController,
      ),
    );
  }
}
