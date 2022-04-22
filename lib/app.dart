import 'package:cppcc_app/page/contacts/contact_detail.dart';
import 'package:cppcc_app/page/contacts/send_business_card_page.dart';
import 'package:cppcc_app/page/home/guandu_historical_details_page.dart';
import 'package:cppcc_app/page/home/guandu_historical_clue_list_page.dart';
import 'package:cppcc_app/page/home/general_tab_switch_list_page.dart';
import 'package:cppcc_app/page/home/guandu_history_list_page.dart';
import 'package:cppcc_app/page/home/leader_mailbox_add_page.dart';
import 'package:cppcc_app/page/home/leader_mailbox_details_page.dart';
// 首页相关页面
import 'package:cppcc_app/page/home/leader_mailbox_page.dart';
import 'package:cppcc_app/page/home/meeting_activities_details_page.dart';
import 'package:cppcc_app/page/home/meeting_activities_page.dart';
import 'package:cppcc_app/page/home/disccuss_network_details_page.dart';
import 'package:cppcc_app/page/home/discuss_network_page.dart';
import 'package:cppcc_app/page/home/performance_file_page.dart';
import 'package:cppcc_app/page/home/posts_list_with_filter_page.dart';
import 'package:cppcc_app/page/home/proposal_manage_page.dart';
import 'package:cppcc_app/page/home/social_opinions_page.dart';
import 'package:cppcc_app/page/login_page.dart';
import 'package:cppcc_app/page/meetings/two_meetings_page.dart';
import 'package:cppcc_app/page/message/message_details_page.dart';
import 'package:cppcc_app/page/posts_details_page.dart';
//资讯相关页面
import 'package:cppcc_app/page/reset_password_page.dart';
import 'package:cppcc_app/page/home/search_page.dart';
import 'package:cppcc_app/page/scan_qr_code_page.dart';
//个人中心页面
import 'package:cppcc_app/page/settings/archives_page.dart';
import 'package:cppcc_app/page/settings/collection_page.dart';
import 'package:cppcc_app/page/settings/feedback_page.dart';
import 'package:cppcc_app/page/settings/settings_page.dart';
import 'package:cppcc_app/page/settings/visiting_card_page.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/navigation_service.dart';
import 'package:cppcc_app/utils/routes.dart';
import 'package:cppcc_app/widget/page_container.dart';
import 'package:flutter/material.dart';

import 'page/home/guandu_historical_add_page.dart';

final RouteObserver<Route> routeObserver = RouteObserver<Route>();

final routesDef = {
  Routes.loginPage: (context) => const LoginPage(),
  Routes.home: (context) => const PageContainer(),
  Routes.resetPasswordPage: (context) => const ResetPasswordPage(),

  //首页相关页面
  Routes.leaderMailboxPage: (context) => const LeaderMailboxPage(),
  Routes.leaderMailboxDetailsPage: (context) =>
      const LeaderMailboxDetailsPage(),
  Routes.leaderMailboxAddPage: (context) => const LeaderMailboxAddPage(),
  Routes.meetingActivitiesPage: (context) => const MeetingActivitiesPage(),
  Routes.meetingActivitiesDetailsPage: (context) =>
      const MeetingActivitiesDetailsPage(),
  Routes.discussNetworkPage: (context) => const DicusssNetworkPage(),
  Routes.discussNetworkDetailsPage: (context) =>
      const DiscussNetworkDetailsPage(),
  Routes.postListWithFilterPage: (context) => const PostsListWithFilterPage(),
  Routes.performanceFilePage: (context) => const PerformanceFilePage(),
  Routes.proposalManagePage: (context) => const ProposalManagePage(),
  Routes.socialOpinionsPage: (context) => const SocialOpinionsPage(),
  Routes.gdHistoricalAddPage: (context) => const GuanduHistoricalAddPage(),
  Routes.guanduHistoricalClueListPage: (context) =>
      const GuanduHistoralcalClueContainer(),
  Routes.guanduHistoricalDetailsPage: (context) =>
      const GuanduHistoricalDetailsPage(),
  Routes.searchPage: (context) => const SearchPage(),
  Routes.scanQRCode: (context) => const ScanQRCodePage(),
  Routes.generalTabSwitchPostsListPage: (context) =>
      const GeneralTabSwitchListPage(),
  Routes.contactDetailPage: (context) => const ContactDetailPage(),
  Routes.sendBusinessCardPage: (context) => const SendBusinessCardPage(),
  Routes.twoMeetingPage: (context) => const TwoMeetingsPage(),
  Routes.guanduHistoryListPage: (context) => const GuanduHistoryListPage(),

  //个人中心相关功能
  Routes.archivesPage: (context) => const ArchivesPage(),
  Routes.collectionPage: (context) => const CollectionPage(),
  Routes.feedbackPage: (context) => const FeedbackPage(),
  Routes.settingsPage: (context) => const SettingsPage(),
  Routes.visitingCardPage: (context) => const VisitingCardPage(),

  //消息相关功能
  Routes.messageDetailsPage: (context) => const MessageDetailsPage(),

  Routes.postsDetailPage: (context) => const PostsDetailPage(),
};

class CppccApp extends StatelessWidget {
  final NavigationService _navigationService;

  const CppccApp(this._navigationService, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = ThemeData(
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white, //修改颜色
        ),
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        elevation: 0.0,
        backgroundColor: AppColors.appOrange
      ),
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
