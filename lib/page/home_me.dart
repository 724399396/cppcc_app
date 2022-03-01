import 'package:flutter/material.dart';
import '../widget/user_list_item.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

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
            EasyRefresh.custom(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate([
                    // 顶部栏
                    new Stack(
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          height: 220.0,
                          color: Color(0xfff27f56),
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
                                        child: new Image.asset(
                                            'assets/icons/ic_wode_selected.png'),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    textDirection: TextDirection.ltr,
                                    verticalDirection: VerticalDirection.down,
                                    children: <Widget>[
                                      Container(
                                        margin: new EdgeInsets.only(top: 10.0),
                                        child: new Text(
                                          "李某某",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      Container(
                                        margin: new EdgeInsets.only(top: 10.0),
                                        child: new Text(
                                          "积分：138****0674",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      Container(
                                        margin: new EdgeInsets.only(top: 10.0),
                                        child: new Text(
                                          "身份证：510************555",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      Container(
                                        margin: new EdgeInsets.only(top: 10.0),
                                        child: new Text(
                                          "职务：政协副主席、XXXXXXXXXXXX",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      Container(
                                        margin: new EdgeInsets.only(top: 10.0),
                                        child: new Text(
                                          "单位：XXXXXXXXXXXXXXX",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.0),
                                        ),
                                      ),
                                    ],
                                  )),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  textDirection: TextDirection.ltr,
                                  verticalDirection: VerticalDirection.down,
                                  children: <Widget>[
                                    Container(
                                      margin: new EdgeInsets.only(left: 10.0),
                                      width: 24.0,
                                      height: 24.0,
                                      child: new PreferredSize(
                                        child: new Container(
                                          child: new ClipOval(
                                            child: new Container(
                                              color: Colors.white,
                                              child: new Image.asset(
                                                  'assets/icons/ic_bianji.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: new EdgeInsets.only(left: 10.0),
                                      width: 24.0,
                                      height: 24.0,
                                      child: new PreferredSize(
                                        child: new Container(
                                          child: new ClipOval(
                                            child: new Container(
                                              color: Colors.white,
                                              child: new Image.asset(
                                                  'assets/icons/ic_erweima.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 名字
                      ],
                    ),
                    // 履职档案部分
                    Container(
                      // margin: new EdgeInsets.only(top: -110.0),
                      width: double.infinity,
                      color: Color(0xffF4F4F4),
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                          color: Color(0xffffffff),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                ListItem(
                                  icon: Image.asset(
                                    'assets/icons/ic_lvzhidanganhdpi.png',
                                  ),
                                  title: "履职档案",
                                  titleColor: Color(0xff5d5d5d),
                                  onPressed: () {},
                                ),
                                ListItem(
                                  icon: Image.asset(
                                    'assets/icons/ic_shouchdpi.png',
                                  ),
                                  title: "我的收藏",
                                  titleColor: Color(0xff5d5d5d),
                                  onPressed: () {},
                                )
                              ],
                            ),
                          )),
                    ),
                    // 工作经历部分
                    Container(
                      width: double.infinity,
                      color: Color(0xffF4F4F4),
                      padding: EdgeInsets.all(10.0),
                      child: Card(
                          color: Color(0xffffffff),
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                ListItem(
                                  icon: Image.asset(
                                    'assets/icons/ic_wodmphdpi.png',
                                  ),
                                  title: "二维码名片",
                                  titleColor: Color(0xff5d5d5d),
                                  onPressed: () {},
                                ),
                                ListItem(
                                  icon: Image.asset(
                                    'assets/icons/ic-banbenhdpi.png',
                                  ),
                                  title: "监测新版本",
                                  titleColor: Color(0xff5d5d5d),
                                  onPressed: () {},
                                ),
                                ListItem(
                                  icon: Image.asset(
                                    'assets/icons/ic_liuyhdpi.png',
                                  ),
                                  title: "建议与反馈",
                                  titleColor: Color(0xff5d5d5d),
                                  onPressed: () {},
                                ),
                                ListItem(
                                  icon: Image.asset(
                                    'assets/icons/ic_shezhihdpi.png',
                                  ),
                                  title: "设置",
                                  titleColor: Color(0xff5d5d5d),
                                  onPressed: () {},
                                )
                              ],
                            ),
                          )),
                    ),
                  ]),
                ),
              ],
            ),
          ],
        ));
  }
}
