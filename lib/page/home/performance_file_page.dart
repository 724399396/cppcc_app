import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          title: const Text("履职档案"),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              color: const Color(0xfff4f4f4),
              child:
                  BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                Contact? userInfo = state.userInfo;
                return ListView(
                  children: [
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
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            textDirection: TextDirection.ltr,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(left: 10.0),
                                width: 112.0,
                                height: 112.0,
                                child: PreferredSize(
                                  child: ClipOval(
                                    child: Container(
                                      color: Colors.white,
                                      child: userInfo?.avatar == null
                                          ? Image.asset(
                                              'assets/icons/ic_wode_selected.png')
                                          : Image.network(
                                              userInfo!.avatar.toString()),
                                    ),
                                  ),
                                  preferredSize: const Size(80.0, 80.0),
                                ),
                              ),
                              Container(
                                  margin: const EdgeInsets.only(left: 10.0),
                                  padding: const EdgeInsets.all(10.0),
                                  height: 160,
                                  width: 210,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    color: Color(0xfffdc88d),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    textDirection: TextDirection.ltr,
                                    verticalDirection: VerticalDirection.down,
                                    children: <Widget>[
                                      Text(
                                        userInfo?.username.toString() ?? '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
                                      ),
                                      const Text(
                                        "评分总分：",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
                                      ),
                                      const Text(
                                        "评价结果：",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.0),
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
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color(0xfffdc88d),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  const Color(0xfffdc88d).withOpacity(1),
                                  const Color(0xfffdc88d).withOpacity(0.3)
                                ]),
                          ),
                          child: const DutiesNumber(),
                        ),
                      ],
                    ),
                    // 基础履职项目
                    Container(
                      width: double.infinity,
                      color: const Color(0xffF4F4F4),
                      padding: const EdgeInsets.all(10.0),
                      child: SettingsDuties(),
                    ),
                    // 履职加分项目
                    Container(
                      width: double.infinity,
                      color: const Color(0xffF4F4F4),
                      padding: const EdgeInsets.all(10.0),
                      child: SettingsSystem(),
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
  const DutiesNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
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
        color: const Color(0xffffffff),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[],
          ),
        ));
  }
}

// 履职加分项目
class SettingsSystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color(0xffffffff),
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[],
          ),
        ));
  }
}
