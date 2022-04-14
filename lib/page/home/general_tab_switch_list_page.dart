import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/dto/post_type.dart';
import 'package:cppcc_app/models/dict.dart';
import 'package:cppcc_app/widget/posts_list_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralTabArgument {
  final String title;
  final String dictKey;
  final PostType postType;
  final Builder floatingActionButton;

  GeneralTabArgument(
      this.title, this.dictKey, this.postType, this.floatingActionButton);
}

class GeneralTabSwitchListPage extends StatefulWidget {
  const GeneralTabSwitchListPage({Key? key}) : super(key: key);

  @override
  State<GeneralTabSwitchListPage> createState() =>
      _GeneralTabSwitchListPageState();
}

class _GeneralTabSwitchListPageState extends State<GeneralTabSwitchListPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late List<Dict>? _tabs;
  late TabController _tabController;

  @override
  @protected
  bool get wantKeepAlive => true;

  void updateTab(dictMap, String key) {
    _tabs = dictMap[key];
    _tabController =
        TabController(initialIndex: 0, length: _tabs?.length ?? 0, vsync: this);
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      var dictMap =
          BlocProvider.of<AppSettingBloc>(context, listen: false).state.dictMap;
      var argument =
          ModalRoute.of(context)?.settings.arguments as GeneralTabArgument;
      updateTab(dictMap, argument.dictKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var argument =
        ModalRoute.of(context)?.settings.arguments as GeneralTabArgument;
    return BlocListener<AppSettingBloc, AppSettingState>(
      listener: (context, state) {
        setState(() {
          updateTab(state.dictMap, argument.dictKey);
        });
      },
      child: Scaffold(
        floatingActionButton: argument.floatingActionButton,
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniEndDocked,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //修改颜色
          ),
          title: Text(
            argument.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xfff27f56),
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
                tabs: _tabs?.map((item) {
                      return Container(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                        child: Text(
                          item.itemText,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabs?.map<Widget>((item) {
                return PostsListContainer(
                    PostKey(argument.postType, int.parse(item.itemValue)));
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
