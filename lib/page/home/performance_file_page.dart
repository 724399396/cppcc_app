import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/user_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class PerformanceFilePage extends StatefulWidget {
  const PerformanceFilePage({Key? key}) : super(key: key);

  @override
  _PerformanceFilePageState createState() => _PerformanceFilePageState();
}

class _PerformanceFilePageState extends State<PerformanceFilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white, //修改颜色
          ),
          title: Text(
            "履职档案",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Color(0xfff27f56),
          elevation: 0.0,
        ),
        backgroundColor: Color(0xfff4f4f4),
        body: Stack(
          children: <Widget>[
            Container(
              color: Color(0xfff4f4f4),
              child:
                  BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                return EasyRefresh.custom(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        // 顶部栏
                        Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 240.0,
                              decoration: const BoxDecoration(
                                color: Color(0xfff27f56),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                textDirection: TextDirection.ltr,
                                verticalDirection: VerticalDirection.down,
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    width: 112.0,
                                    height: 112.0,
                                    child: PreferredSize(
                                      child: Container(
                                        child: ClipOval(
                                          child: Container(
                                            color: Colors.white,
                                            child: state.avatar == null
                                                ? Image.asset(
                                                    'assets/icons/ic_wode_selected.png')
                                                : Image.network(
                                                    state.avatar.toString()),
                                          ),
                                        ),
                                      ),
                                      preferredSize: new Size(80.0, 80.0),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      padding: EdgeInsets.all(10.0),
                                      height: 160,
                                      width: 210,
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        color: Color(0xfffdc88d),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        textDirection: TextDirection.ltr,
                                        verticalDirection:
                                            VerticalDirection.down,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              state.username.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "评分总分：" + state.phone.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "评价结果：" + state.idCard.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            ),
                            // 履职编号部分
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 200.0, left: 15, right: 15),
                              width: double.infinity,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: Color(0xfffdc88d),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0)),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xfffdc88d).withOpacity(1),
                                      Color(0xfffdc88d).withOpacity(0.3)
                                    ]),
                              ),
                              child: DutiesNumber(),
                            ),
                          ],
                        ),
                        // 基础履职项目
                        Container(
                          width: double.infinity,
                          color: Color(0xffF4F4F4),
                          padding: EdgeInsets.all(10.0),
                          child: SettingsDuties(),
                        ),
                        // 履职加分项目
                        Container(
                          width: double.infinity,
                          color: Color(0xffF4F4F4),
                          padding: EdgeInsets.all(10.0),
                          child: SettingsSystem(),
                        ),
                      ]),
                    ),
                  ],
                );
              }),
            ),
          ],
        ));
  }
}

// 履职编号部分
class DutiesNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {},
      padding: EdgeInsets.all(0.0),
      shape: Border.all(
        color: Colors.transparent,
        width: 0.0,
        style: BorderStyle.none,
      ),
      child: Container(
          height: 38.0,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "基础履职项目",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "90分",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(),
            ],
          )),
    );
  }
}

// 基础履职项目
class SettingsDuties extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xffffffff),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              UserListItem(
                title: "项目一",
                titleColor: Color(0xff5d5d5d),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.archivesPage);
                },
              ),
              UserListItem(
                title: "项目一",
                titleColor: Color(0xff5d5d5d),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.collectionPage);
                },
              )
            ],
          ),
        ));
  }
}

// 履职加分项目
class SettingsSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Color(0xffffffff),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              UserListItem(
                title: "项目内容XXXXX",
                titleColor: Color(0xff5d5d5d),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.visitingCardPage);
                },
              ),
              UserListItem(
                title: "项目内容XXXXX",
                titleColor: Color(0xff5d5d5d),
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}
