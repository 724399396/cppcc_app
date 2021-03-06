import 'package:cppcc_app/bloc/opinion_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/models/opinions.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:cppcc_app/widget/opinion_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SocialOpinionsPage extends StatefulWidget {
  const SocialOpinionsPage({Key? key}) : super(key: key);

  @override
  _SocialOpinionsPageState createState() => _SocialOpinionsPageState();
}

class _SocialOpinionsPageState extends State<SocialOpinionsPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late List<OpinionListType> _tabs;
  bool filterSelf = false;

  @override
  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabs = [OpinionListType.notFinished, OpinionListType.finished];
    _tabController =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("社情民意"),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
      floatingActionButton: _tabController.index == 0
          ? Stack(
              children: [
                FloatingActionButton.extended(
                  heroTag: 'mine',
                  icon: const Icon(Icons.my_library_books_outlined),
                  backgroundColor: const Color(0xfff27f56),
                  foregroundColor: Colors.white,
                  label: Text(filterSelf ? "全部" : "我的"),
                  onPressed: () {
                    setState(() {
                      filterSelf = !filterSelf;
                    });
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
                        Navigator.of(context)
                            .pushNamed(Routes.socialOpinionsAddPage);
                      },
                    )),
              ],
            )
          : Container(),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((item) {
          return OpinionList(
            item,
            _tabController.index == 0 && filterSelf,
          );
        }).toList(),
      ),
    );
  }
}

// 列表信息
class OpinionList extends StatefulWidget {
  final OpinionListType _listType;
  final bool _filterSelf;
  const OpinionList(this._listType, this._filterSelf, {Key? key})
      : super(key: key);

  @override
  State<OpinionList> createState() => _OpinionListState();
}

class _OpinionListState extends State<OpinionList> {
  String _searchKeyWord = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          GeneralSearch(
            AppColors.greyTextColor,
            (context, keyword) {
              setState(() {
                _searchKeyWord = keyword;
              });
            },
            initValue: _searchKeyWord,
            fillColor: Colors.white,
          ),
          Expanded(
            child:
                BlocEasyFrefresh<OpinionBloc, OpinionState, Opinion>((state) {
              var data = state.opinions[widget._listType] ?? [];
              var filterData = (_searchKeyWord.isEmpty
                      ? data
                      : data
                          .where((d) => d.title.contains(_searchKeyWord))
                          .toList())
                  .where((element) => widget._filterSelf
                      ? element.authorId ==
                          BlocProvider.of<UserBloc>(context)
                              .state
                              .userInfo
                              ?.userId
                      : true)
                  .toList();
              return filterData;
            }, () async {
              BlocProvider.of<OpinionBloc>(context)
                  .add(OpinionLoadMore(widget._listType));
            }, () async {
              BlocProvider.of<OpinionBloc>(context)
                  .add(OpinionRefresh(widget._listType));
            }, (p) => OpinionItem(p)),
          )
        ],
      ),
      // ),
    );
  }
}
