import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PerformanceFilePage extends StatelessWidget {
  const PerformanceFilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("履职档案"),
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          TextStyle labelStyle = const TextStyle(fontSize: 16);
          return Stack(
            children: [
              // 顶部栏
              Container(
                width: double.infinity,
                height: 220.0,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.appOrange, Color(0xFFe45a2a)]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text('2022年度',
                            style:
                                TextStyle(fontSize: 14, color: Colors.white)),
                        Icon(Icons.expand_more, size: 18, color: Colors.white)
                      ],
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40.0,
                          backgroundImage: state.userInfo?.avatar == null
                              ? Image.asset('assets/icons/ic_wode_selected.png')
                                  .image
                              : CachedNetworkImageProvider(
                                  state.userInfo!.avatar.toString()),
                        ),
                        const SizedBox(width: 32),
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.all(16),
                              height: 160,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                color: Color(0x77ffc3a1),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.ideographic,
                                    children: [
                                      Text("评分总分", style: labelStyle),
                                      Expanded(child: Container()),
                                      const Text('100',
                                          style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFfb5117))),
                                      const SizedBox(width: 2),
                                      Text('分',
                                          style: labelStyle.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: const Color(0xFFfb5117))),
                                      Expanded(child: Container()),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    textBaseline: TextBaseline.ideographic,
                                    children: [
                                      Text("评价结果", style: labelStyle),
                                      const SizedBox(width: 8),
                                      const Expanded(
                                          child: Text(
                                              '评价内容xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
                                              softWrap: true,
                                              maxLines: 3,
                                              style: TextStyle(fontSize: 14))),
                                      const SizedBox(width: 8),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // 基础履职项目
                    const DutiesBasicProject(),
                    const SizedBox(height: 18),
                    // 履职加分项目
                    const DutiesExtraProject(),
                  ],
                ),
              ),
              // 履职编号部分
            ],
          );
        }));
  }
}

class DutiesBasicProject extends StatelessWidget {
  const DutiesBasicProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Color(0xfffdc88d),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "基础履职项目",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: Container()),
                const Text(
                  "90分",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/ic_xm1.png', width: 28),
                  const Text('项目一'),
                ],
              ),
              const SizedBox(height: 8),
              const ProjectItem("项目内容xxxxxx", "无扣分", Color(0xFFfcc88e)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/ic_xm1.png', width: 28),
                  const Text('项目一'),
                ],
              ),
              const SizedBox(height: 8),
              const ProjectItem("项目内容xxxxxx", "扣10分", Color(0xFFfcc88e))
            ]),
          ),
        ],
      ),
    );
  }
}

class DutiesExtraProject extends StatelessWidget {
  const DutiesExtraProject({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              color: Color(0xffbedffe),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "履职加分项目",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(child: Container()),
                const Text(
                  "10分",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/ic_xm2.png', width: 28),
                  const Text('项目一'),
                ],
              ),
              const SizedBox(height: 8),
              const ProjectItem("项目内容xxxxxx", "加10分", Color(0xffbedffe)),
            ]),
          ),
        ],
      ),
    );
  }
}

class ProjectItem extends StatelessWidget {
  final String name;
  final String point;
  final Color prefixColor;
  const ProjectItem(
    this.name,
    this.point,
    this.prefixColor, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Color(0xFFF4F4F4),
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(children: [
        const SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
              color: prefixColor,
              borderRadius: const BorderRadius.all(Radius.circular(8))),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(name)),
        Text(
          point,
          style: const TextStyle(color: Color(0xFF009adc)),
        ),
        const SizedBox(width: 8),
      ]),
    );
  }
}
