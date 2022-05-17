import 'package:cppcc_app/bloc/proposal_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/models/proposal.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/easy_refresh.dart';
import 'package:cppcc_app/widget/empty_data.dart';
import 'package:cppcc_app/widget/general_search.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:intl/intl.dart';

class ProposalManagePage extends StatefulWidget {
  const ProposalManagePage({Key? key}) : super(key: key);

  @override
  _ProposalManagePageState createState() => _ProposalManagePageState();
}

class _ProposalManagePageState extends State<ProposalManagePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;
  late List<ProposalListType> _tabs;
  bool filterSelf = false;

  @override
  @protected
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabs = [ProposalListType.year, ProposalListType.excellent];
    _tabController =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("提案办理"),
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
                        Navigator.of(context).pushNamed(Routes.proposalAddPage);
                      },
                    )),
              ],
            )
          : Container(),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((item) {
          return ProposalList(
            item,
            _tabController.index == 0 && filterSelf,
          );
        }).toList(),
      ),
    );
  }
}

class ProposalList extends StatefulWidget {
  final ProposalListType _listType;
  final bool _filterSelf;
  const ProposalList(this._listType, this._filterSelf, {Key? key})
      : super(key: key);

  @override
  State<ProposalList> createState() => _ProposalListState();
}

class _ProposalListState extends State<ProposalList> {
  String _searchKeyWord = "";
  int? selectYear;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProposalBloc>(context)
        .add(ProposalFirstFetch(widget._listType));
    final _easyRefreshController = EasyRefreshController();
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: BlocConsumer<ProposalBloc, ProposalState>(
        buildWhen: (previous, current) =>
            previous.proposals != current.proposals ||
            previous.status != current.status,
        listenWhen: (previous, current) =>
            previous.proposals != current.proposals ||
            previous.status != current.status,
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
          var data = state.proposals[widget._listType] ?? [];
          selectYear ??= data.map((e) => e.year).fold(
              null,
              (value, element) =>
                  (value == null || value < element) ? element : value);
          var filterData = (_searchKeyWord.isEmpty
                  ? data
                  : data
                      .where((d) => d.title.contains(_searchKeyWord))
                      .toList())
              .where((element) => widget._filterSelf
                  ? element.authorId ==
                      BlocProvider.of<UserBloc>(context).state.userInfo?.userId
                  : true)
              .where((element) =>
                  selectYear != null ? element.year == selectYear : true)
              .toList();
          var years = data.map((e) => e.year).toSet().toList();
          years.sort((a, b) => b.compareTo(a));
          return Column(
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
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        hint: Text(
                          '选择年度',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: years
                            .map((item) => DropdownMenuItem<int>(
                                  value: item,
                                  child: Text(
                                    '$item 年度',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectYear,
                        onChanged: (value) {
                          setState(() {
                            selectYear = value as int;
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 100,
                        itemHeight: 40,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                  child: EasyRefresh.custom(
                controller: _easyRefreshController,
                enableControlFinishRefresh: true,
                enableControlFinishLoad: true,
                header: easyRefreshHeader,
                footer: easyRefreshFooter,
                onLoad: () async {
                  BlocProvider.of<ProposalBloc>(context)
                      .add(ProposalLoadMore(widget._listType));
                },
                onRefresh: () async {
                  BlocProvider.of<ProposalBloc>(context)
                      .add(ProposalRefresh(widget._listType));
                },
                emptyWidget: filterData.isEmpty ? const EmptyData() : null,
                slivers: filterData.map((p) => ProposalItem(p)).toList(),
              ))
            ],
          );
        },
      ),
      // ),
    );
  }
}

class ProposalItem extends StatelessWidget {
  final Proposal _bean;
  const ProposalItem(this._bean, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(Routes.proposalDetailPage, arguments: _bean);
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _bean.read
                    ? Container()
                    : Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 8),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFfa7c2f),
                        )),
                Expanded(
                    child: Text(
                  _bean.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(color: Colors.black),
                ))
              ],
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  Text(
                    _bean.author,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.greyTextColor),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('yyyy-MM-dd').format(_bean.createTime),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: AppColors.greyTextColor),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          Routes.proposalProgressPage,
                          arguments: _bean);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFF66cc00)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 6),
                      child: Text(
                        _bean.statusDictText,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: const Color(0xFF66cc00)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
