import 'package:cppcc_app/page/login_page.dart';
import 'package:cppcc_app/page/reset_password_page.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/navigation_service.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/page_container.dart';
import 'package:flutter/material.dart';


//个人中心页面
import 'package:cppcc_app/page/settings/archives_page.dart';
import 'package:cppcc_app/page/settings/collection_page.dart';
import 'package:cppcc_app/page/settings/feedback_page.dart';
import 'package:cppcc_app/page/settings/settings_page.dart';
import 'package:cppcc_app/page/settings/visiting_card_page.dart';

import 'package:cppcc_app/page/message/message_details_page.dart';

final RouteObserver<Route> routeObserver = RouteObserver<Route>();

final routesDef = {
  Routes.loginPage: (context) => const LoginPage(),
  Routes.home: (context) => const PageContainer(),
  Routes.resetPasswordPage: (context) => const ResetPasswordPage(),

  //个人中心相关功能
  Routes.archivesPage: (context) => const ArchivesPage(),
  Routes.collectionPage: (context) => const CollectionPage(),
  Routes.feedbackPage: (context) => const FeedbackPage(),
  Routes.settingsPage: (context) => const SettingsPage(),
  Routes.visitingCardPage: (context) => const VisitingCardPage(),

  //消息相关功能
  Routes.messageDetailsPage: (context) => const MessageDetailsPage(),


};

class CppccApp extends StatelessWidget {
  final NavigationService _navigationService;

  const CppccApp(this._navigationService, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = ThemeData(
      primarySwatch: AppColors.primary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      // content
      backgroundColor: AppColors.background,
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.textColor,
            displayColor: AppColors.textColor,
          ),
      // headings -- contrasts 'primary color'
      primaryTextTheme: Theme.of(context).textTheme.apply(
            bodyColor: AppColors.displayTextColor,
            displayColor: AppColors.displayTextColor,
          ),
      // ui -- contrasts 'accent color'
      primaryColor: AppColors.primary,
      primaryIconTheme: Theme.of(context)
          .iconTheme
          .copyWith(color: AppColors.displayTextColor),
    );

    return MaterialApp(
      title: '官渡政协',
      debugShowCheckedModeBanner: false,
      theme: _theme,
      routes: routesDef,
      home: const PageContainer(),
      navigatorObservers: [routeObserver],
      navigatorKey: _navigationService.navigatorKey,
    );
  }
}
