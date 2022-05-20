import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cppcc_app/repository/app_setting_repository.dart';
import 'package:cppcc_app/repository/upload_repository.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:version/version.dart';
import '../widget/user_list_item.dart';
import 'package:cppcc_app/utils/routes.dart';

import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// 个人中心页面
class HomeMe extends StatelessWidget {
  const HomeMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("我"),
        ),
        body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
          final TextStyle? userFiledStyle =
              themeData.textTheme.bodyText2?.copyWith(color: Colors.white);
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
                  gradient: LinearGradient(
                      colors: [AppColors.appOrange, Color(0xFFe45a2a)]),
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
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, Routes.personSettingPage);
                                      },
                                      child: Image.asset(
                                        'assets/icons/ic_bianji.png',
                                        width: 36,
                                      ),
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.performanceFilePage);
      },
      child: SizedBox(
          height: 48.0,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 14),
              SizedBox(
                height: 32.0,
                width: 32.0,
                child: Image.asset('assets/icons/ic_ka.png'),
              ),
              const SizedBox(width: 14),
              const Text(
                "履职卡号",
                style: TextStyle(fontSize: 18, color: Color(0xfffcdcb4)),
              ),
              Expanded(child: Container()),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: const BoxDecoration(
                      color: Color(0xfffee0be),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Text(
                    "NO.123",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(width: 14),
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
            Navigator.of(context).pushNamed(Routes.performanceFilePage);
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
        AppUpgrader(),
        const SizedBox(height: 4),
        UserListItem(
          icon: Image.asset(
            'assets/icons/ic_wodmphdpi.png',
          ),
          title: "二维码名片",
          onClick: () {
            Navigator.of(context).pushNamed(Routes.qrBusinessCardPage);
          },
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

class AppUpgrader extends StatefulWidget {
  const AppUpgrader({
    Key? key,
  }) : super(key: key);

  @override
  State<AppUpgrader> createState() => _AppUpgraderState();
}

class _AppUpgraderState extends State<AppUpgrader> {
  bool onUpdated = false;
  @override
  Widget build(BuildContext context) {
    return UserListItem(
      icon: Image.asset(
        'assets/icons/ic-banbenhdpi.png',
      ),
      title: "检测新版本",
      onClick: () async {
        if (onUpdated) {
          showToast('更新中，请耐心等待;');
          return;
        }
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        var latestVersionInfo =
            await RepositoryProvider.of<AppSettingRepository>(context)
                .getLatestAppVersion();
        var latestVersion = latestVersionInfo.version;
        if (Version.parse(latestVersion) > Version.parse(packageInfo.version)) {
          if (Platform.isAndroid) {
            showToast('检测到新版本，更新中，下载完成后自动打开安装界面，请耐心等待');
            onUpdated = true;
            var tempDir = await getTemporaryDirectory();
            String fullPath = tempDir.path + "/" + latestVersion + ".apk";
            File file = File(fullPath);
            bool exists = await file.exists();
            if (!exists) {
              var bytes = await RepositoryProvider.of<FileRepository>(context)
                  .download(latestVersionInfo.apkUrl);
              await file.writeAsBytes(bytes);
            }
            onUpdated = false;
            OpenFile.open(fullPath);
          }
          if (Platform.isIOS) {
            String androidAppId = 'com.lingrit.cppcc.app';
            // TODO
            String iOSAppId = '';
            AppInstaller.goStore(androidAppId, iOSAppId);
          }
        }
      },
    );
  }
}
