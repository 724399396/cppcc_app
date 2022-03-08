import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../widget/user_list_item.dart';
import 'package:cppcc_app/utils/routes.dart';

import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 个人中心页面
class HomeMe extends StatefulWidget {
  @override
  _HomeMeState createState() => _HomeMeState();
}

class _HomeMeState extends State<HomeMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "我",
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
                // print("==username===" + state.username.toString());
                return EasyRefresh.custom(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        // 顶部栏
                        new Stack(
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 280.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(0.0),
                                  topRight: Radius.circular(0.0),
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                                color: Color(0xfff27f56),
                              ),
                            ),
                            Container(
                              margin: new EdgeInsets.only(top: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                textDirection: TextDirection.ltr,
                                verticalDirection: VerticalDirection.down,
                                children: <Widget>[
                                  Container(
                                    margin: new EdgeInsets.only(left: 10.0),
                                    width: 112.0,
                                    height: 112.0,
                                    child: new PreferredSize(
                                      child: new Container(
                                        child: new ClipOval(
                                          child: new Container(
                                            color: Colors.white,
                                            child: state.avatar == null
                                                ? new Image.asset(
                                                    'assets/icons/ic_wode_selected.png')
                                                : new Image.network(
                                                    state.avatar.toString()),
                                          ),
                                        ),
                                      ),
                                      preferredSize: new Size(80.0, 80.0),
                                    ),
                                  ),
                                  Container(
                                      margin: new EdgeInsets.only(left: 10.0),
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
                                            margin:
                                                new EdgeInsets.only(top: 10.0),
                                            child: new Text(
                                              state.username.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                new EdgeInsets.only(top: 10.0),
                                            child: new Text(
                                              "手机：" + state.phone.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                new EdgeInsets.only(top: 10.0),
                                            child: new Text(
                                              "身份证：" + state.idCard.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                new EdgeInsets.only(top: 10.0),
                                            child: new Text(
                                              "职务：" + state.post.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                new EdgeInsets.only(top: 10.0),
                                            child: new Text(
                                              "单位：" + state.company.toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.max,
                                      textDirection: TextDirection.ltr,
                                      verticalDirection: VerticalDirection.down,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              new EdgeInsets.only(left: 10.0),
                                          width: 24.0,
                                          height: 24.0,
                                          child: new Container(
                                            child: new Image.asset(
                                                'assets/icons/ic_bianji.png'),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              new EdgeInsets.only(left: 10.0),
                                          width: 24.0,
                                          height: 24.0,
                                          child: new Container(
                                            child: new Image.asset(
                                                'assets/icons/ic_erweima.png'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // 履职编号部分
                            Container(
                              margin: new EdgeInsets.only(
                                  top: 200.0, left: 15, right: 15),
                              width: double.infinity,
                              padding: EdgeInsets.all(10.0),
                              // opacity: 0.5,
                              decoration: BoxDecoration(
                                color: Color(0xffffe0be),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffffe0be).withOpacity(0.1),
                                      Color(0xffffe0be).withOpacity(0.3)
                                    ]),
                              ),

                              child: DutiesNumber(),
                            ),
                            // 名字
                          ],
                        ),
                        // 履职档案部分
                        Container(
                          width: double.infinity,
                          color: Color(0xffF4F4F4),
                          padding: EdgeInsets.all(10.0),
                          child: SettingsDuties(),
                        ),
                        // 工作经历部分
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
      onPressed: () {
        Navigator.of(context).pushNamed(Routes.archivesPage);
      },
      padding: EdgeInsets.all(0.0),
      shape: Border.all(
        color: Colors.transparent,
        width: 0.0,
        style: BorderStyle.none,
      ),
      child: Container(
          height: 48.0,
          width: double.infinity,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(14.0),
                child: SizedBox(
                  height: 32.0,
                  width: 32.0,
                  child: Image.asset('assets/icons/ic_ka.png'),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "履职卡号",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 14.0,
              ),
            ],
          )),
    );
  }
}

// 履职档案部分
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
                icon: Image.asset(
                  'assets/icons/ic_lvzhidanganhdpi.png',
                ),
                title: "履职档案",
                titleColor: Color(0xff5d5d5d),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.archivesPage);
                },
              ),
              UserListItem(
                icon: Image.asset(
                  'assets/icons/ic_shouchdpi.png',
                ),
                title: "我的收藏",
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

// 系统设置部分
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
                icon: Image.asset(
                  'assets/icons/ic_wodmphdpi.png',
                ),
                title: "二维码名片",
                titleColor: Color(0xff5d5d5d),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.visitingCardPage);
                },
              ),
              UserListItem(
                icon: Image.asset(
                  'assets/icons/ic-banbenhdpi.png',
                ),
                title: "监测新版本",
                titleColor: Color(0xff5d5d5d),
                onPressed: () {},
              ),
              UserListItem(
                icon: Image.asset(
                  'assets/icons/ic_liuyhdpi.png',
                ),
                title: "建议与反馈",
                titleColor: Color(0xff5d5d5d),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.feedbackPage);
                },
              ),
              UserListItem(
                icon: Image.asset(
                  'assets/icons/ic_shezhihdpi.png',
                ),
                title: "设置",
                titleColor: Color(0xff5d5d5d),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.settingsPage);
                },
              )
            ],
          ),
        ));
  }
}
