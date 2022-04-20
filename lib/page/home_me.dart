import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../widget/user_list_item.dart';
import 'package:cppcc_app/utils/routes.dart';

import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// 个人中心页面
class HomeMe extends StatelessWidget {
  const HomeMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "我",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFFB7D30),
          elevation: 0.0,
        ),
        backgroundColor: const Color(0xfff4f4f4),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          final TextStyle? userFiledStyle =
              themeData.textTheme.bodyText1?.copyWith(color: Colors.white);
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                  color: Color(0xFFFB7D30),
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40.0,
                            backgroundImage: state.userInfo?.avatar == null
                                ? Image.asset(
                                        'assets/icons/ic_wode_selected.png')
                                    .image
                                : CachedNetworkImageProvider(
                                    state.userInfo!.avatar.toString()),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      state.userInfo?.realname ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          ?.copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20),
                                          right: Radius.circular(20),
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 2, horizontal: 12),
                                      child: Text(
                                        (state.userInfo?.postDictText.isEmpty ??
                                                true)
                                            ? '政协委员'
                                            : state.userInfo!.postDictText,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: const Color(0xFFf68266)),
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Image.asset(
                                      'assets/icons/ic_bianji.png',
                                      width: 36,
                                    ),
                                    const SizedBox(width: 4),
                                    Image.asset(
                                      'assets/icons/ic_erweima.png',
                                      width: 36,
                                    )
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(children: [
                                  Text('电话:', style: userFiledStyle),
                                  const SizedBox(width: 6),
                                  Text(
                                    (state.userInfo != null &&
                                            state.userInfo?.phone.length == 11)
                                        ? (state.userInfo!.phone
                                                .substring(0, 3) +
                                            '****' +
                                            state.userInfo!.phone.substring(7))
                                        : '',
                                    style: userFiledStyle,
                                  ),
                                ]),
                                const SizedBox(height: 8),
                                Row(children: [
                                  Text('身份证号:', style: userFiledStyle),
                                  const SizedBox(width: 6),
                                  Text(
                                    (state.userInfo != null &&
                                            state.userInfo?.idCard.length == 18)
                                        ? (state.userInfo!.idCard
                                                .substring(0, 6) +
                                            '********' +
                                            state.userInfo!.idCard
                                                .substring(14))
                                        : '',
                                    style: userFiledStyle,
                                  ),
                                ]),
                                const SizedBox(height: 8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('职务:', style: userFiledStyle),
                                    const SizedBox(width: 6),
                                    Expanded(
                                        child: Text(
                                            state.userInfo?.position ?? '',
                                            style: userFiledStyle)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text('单位:', style: userFiledStyle),
                                    const SizedBox(width: 6),
                                    Text(state.userInfo?.company ?? '',
                                        style: userFiledStyle),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      // 履职编号部分
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10.0),
                        // opacity: 0.5,
                        decoration: BoxDecoration(
                          color: const Color(0x88ffe0be),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                          gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                const Color(0xffffe0be).withOpacity(0.1),
                                const Color(0xffffe0be).withOpacity(0.3)
                              ]),
                        ),

                        child: const DutiesNumber(),
                      ),
                      const SizedBox(height: 12),
                      // 履职档案部分
                      const SettingsDuties(),
                      const SizedBox(height: 24),
                      // 工作经历部分
                      const SettingsSystem(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
  }
}

// 履职编号部分
class DutiesNumber extends StatelessWidget {
  const DutiesNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.performanceFilePage);
      },
      child: SizedBox(
          height: 48.0,
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(14.0),
                child: SizedBox(
                  height: 32.0,
                  width: 32.0,
                  child: Image.asset('assets/icons/ic_ka.png'),
                ),
              ),
              Text(
                "履职卡号",
                style: themeData.textTheme.titleLarge
                    ?.copyWith(color: const Color(0xfffcdcb4)),
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
  const SettingsDuties({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListItem(
          icon: Image.asset(
            'assets/icons/ic_lvzhidanganhdpi.png',
          ),
          title: "履职档案",
          onClick: () {
            Navigator.of(context).pushNamed(Routes.archivesPage);
          },
        ),
        const SizedBox(height: 4),
        UserListItem(
          icon: Image.asset(
            'assets/icons/ic_shouchdpi.png',
          ),
          title: "我的收藏",
          onClick: () {
            Navigator.of(context).pushNamed(Routes.collectionPage);
          },
        )
      ],
    );
  }
}

// 系统设置部分
class SettingsSystem extends StatelessWidget {
  const SettingsSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        UserListItem(
          icon: Image.asset(
            'assets/icons/ic_wodmphdpi.png',
          ),
          title: "二维码名片",
          onClick: () {
            Navigator.of(context).pushNamed(Routes.visitingCardPage);
          },
        ),
        const SizedBox(height: 4),
        UserListItem(
          icon: Image.asset(
            'assets/icons/ic-banbenhdpi.png',
          ),
          title: "监测新版本",
          onClick: () {},
        ),
        const SizedBox(height: 4),
        UserListItem(
          icon: Image.asset(
            'assets/icons/ic_liuyhdpi.png',
          ),
          title: "建议与反馈",
          onClick: () {
            Navigator.of(context).pushNamed(Routes.feedbackPage);
          },
        ),
        const SizedBox(height: 4),
        UserListItem(
          icon: Image.asset(
            'assets/icons/ic_shezhihdpi.png',
          ),
          title: "设置",
          onClick: () {
            Navigator.of(context).pushNamed(Routes.settingsPage);
          },
        )
      ],
    );
  }
}
