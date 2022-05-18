import 'package:cppcc_app/page/contacts/contact_detail.dart';
import 'package:cppcc_app/page/contacts/send_business_card_page.dart';
import 'package:cppcc_app/page/discuss_file_detail_page.dart';
import 'package:cppcc_app/page/file_annment_details_page.dart';
import 'package:cppcc_app/page/home/discuss_network_file_page.dart';
import 'package:cppcc_app/page/home/guandu_historical_details_page.dart';
import 'package:cppcc_app/page/home/guandu_historical_clue_list_page.dart';
import 'package:cppcc_app/page/home/committe_study_page.dart';
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
import 'package:cppcc_app/page/home/file_annment_page.dart';
import 'package:cppcc_app/page/home/proposal_add_page.dart';
import 'package:cppcc_app/page/home/proposal_reply_list_page.dart';
import 'package:cppcc_app/page/home/proposal_manage_page.dart';
import 'package:cppcc_app/page/home/social_opinion_add_page.dart';
import 'package:cppcc_app/page/home/social_opinions_page.dart';
import 'package:cppcc_app/page/login_page.dart';
import 'package:cppcc_app/page/meetings/two_meetings_page.dart';
import 'package:cppcc_app/page/message/message_details_page.dart';
import 'package:cppcc_app/page/opinion_details_page.dart';
import 'package:cppcc_app/page/opinion_progress_page.dart';
import 'package:cppcc_app/page/proposal_details_page.dart';
import 'package:cppcc_app/page/proposal_progress_page.dart';
import 'package:cppcc_app/page/reply_detail_page.dart';
import 'package:cppcc_app/page/settings/update_password_page.dart';
import 'package:cppcc_app/page/settings/user_setting_page.dart';
import 'package:cppcc_app/page/posts_details_page.dart';
//资讯相关页面
import 'package:cppcc_app/page/reset_password_page.dart';
import 'package:cppcc_app/page/home/search_page.dart';
import 'package:cppcc_app/page/scan_qr_code_page.dart';
//个人中心页面
import 'package:cppcc_app/page/settings/collection_page.dart';
import 'package:cppcc_app/page/settings/feedback_page.dart';
import 'package:cppcc_app/page/settings/settings_page.dart';
import 'package:cppcc_app/page/settings/update_phone_page.dart';
import 'package:cppcc_app/page/settings/qr_business_card_apge.dart';
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
  Routes.fileAnnmentPage: (context) => const FileAnnmentPage(),
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
  Routes.committeStudyPage: (context) => const CommitteStudyPage(),
  Routes.contactDetailPage: (context) => const ContactDetailPage(),
  Routes.sendBusinessCardPage: (context) => const SendBusinessCardPage(),
  Routes.twoMeetingPage: (context) => const TwoMeetingsPage(),
  Routes.guanduHistoryListPage: (context) => const GuanduHistoryListPage(),
  Routes.collectionPage: (context) => const CollectionPage(),
  Routes.feedbackPage: (context) => const FeedbackPage(),
  Routes.settingsPage: (context) => const SettingsPage(),
  Routes.qrBusinessCardPage: (context) => const QrBusinessCardPage(),
  Routes.messageDetailsPage: (context) => const MessageDetailsPage(),
  Routes.postsDetailPage: (context) => const PostsDetailPage(),
  Routes.personSettingPage: (context) => const UserSettingPage(),
  Routes.updatePhonePage: (context) => const UpdatePhonePage(),
  Routes.updatePasswordPage: (context) => const UpdatePasswordPage(),
  Routes.socialOpinionsAddPage: (context) => const SocialOpinionAddPage(),
  Routes.opinionDetailPage: (context) => const OpinionDetailsPage(),
  Routes.opinionProgressPage: (context) => const OpinionProgressPage(),
  Routes.proposalAddPage: (context) => const ProposalAddPage(),
  Routes.proposalDetailPage: (context) => const ProposalDetailsPage(),
  Routes.proposalProgressPage: (context) => const ProposalProgressPage(),
  Routes.proposalReplyListPage: (context) => const ProposalReplyListPage(),
  Routes.replayDetailPage: (context) => const ReplyDetailsPage(),
  Routes.fileAnnmentDetailsPage: (context) => const FileAnnmentDetailsPage(),
  Routes.discussNetworkFilePage: (context) => const DiscussNetworkFilePage(),
  Routes.dicussFileDetailsPage: (context) => const DiscussFileDetailsPage(),
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
          backgroundColor: AppColors.appOrange),
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
