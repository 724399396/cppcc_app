import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/contact_bloc.dart';
import 'package:cppcc_app/bloc/discuss_network_bloc.dart';
import 'package:cppcc_app/bloc/guandu_historical_clue_bloc.dart';
import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:cppcc_app/bloc/notice_bloc.dart';
import 'package:cppcc_app/bloc/opinion_bloc.dart';
import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/bloc/proposal_bloc.dart';
import 'package:cppcc_app/bloc/timer_bloc.dart';
import 'package:cppcc_app/bloc/two_meetings_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/repository/api_provider.dart';
import 'package:cppcc_app/repository/app_setting_repository.dart';
import 'package:cppcc_app/repository/contact_repository.dart';
import 'package:cppcc_app/repository/discuss_network_repository.dart';
import 'package:cppcc_app/repository/guandu_historical_clue_repository.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';
import 'package:cppcc_app/repository/mailbox_repository.dart';
import 'package:cppcc_app/repository/meeting_repository.dart';
import 'package:cppcc_app/repository/notice_repository.dart';
import 'package:cppcc_app/repository/opinion_repository.dart';
import 'package:cppcc_app/repository/post_repository.dart';
import 'package:cppcc_app/repository/proposal_repository.dart';
import 'package:cppcc_app/repository/two_meetings_repository.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/navigation_service.dart';
import 'package:cppcc_app/utils/time_ago_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cppcc_app/repository/user_repository.dart';
//消息
import 'package:cppcc_app/repository/message_repository.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.primary,
  ));

  var localDataProvider = LocalDataProvider();
  var navigationService = NavigationService();
  var apiDataProvider = ApiDataProvider(
      Dio(BaseOptions(
        // TODO
        // baseUrl: 'https://' + baseUrl,
        baseUrl: 'http://' + baseUrl,
        connectTimeout: 10000,
        receiveTimeout: 10000,
      )),
      localDataProvider,
      navigationService);
  await localDataProvider.init();

  timeago.setLocaleMessages('zh', ZhCustomMessages());

  // Don't allow landscape mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) =>
              UserRepository(localDataProvider, apiDataProvider),
        ),
        RepositoryProvider<AppSettingRepository>(
          create: (context) => AppSettingRepository(apiDataProvider),
        ),
        RepositoryProvider<MessageRepository>(
          create: (context) => MessageRepository(apiDataProvider),
        ),
        RepositoryProvider<PostRepository>(
          create: (context) => PostRepository(apiDataProvider),
        ),
        RepositoryProvider<MailboxRepository>(
          create: (context) => MailboxRepository(apiDataProvider),
        ),
        RepositoryProvider<DiscussNetworkRepository>(
          create: (context) => DiscussNetworkRepository(apiDataProvider),
        ),
        RepositoryProvider<MeetingRepository>(
          create: (context) => MeetingRepository(apiDataProvider),
        ),
        RepositoryProvider<GuanduHistoricalClueRepository>(
          create: (context) => GuanduHistoricalClueRepository(apiDataProvider),
        ),
        RepositoryProvider<OpinionRepository>(
          create: (context) => OpinionRepository(apiDataProvider),
        ),
        RepositoryProvider<ProposalRepository>(
          create: (context) => ProposalRepository(apiDataProvider),
        ),
        RepositoryProvider<NoticeRepository>(
          create: (context) => NoticeRepository(apiDataProvider),
        ),
        RepositoryProvider<ContactRepository>(
          create: (context) => ContactRepository(apiDataProvider),
        ),
        RepositoryProvider<TwoMeetingsRepository>(
          create: (context) => TwoMeetingsRepository(apiDataProvider),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TimerBloc>(
            create: (BuildContext context) => TimerBloc(),
          ),
          BlocProvider<UserBloc>(
            lazy: false,
            create: (BuildContext context) => UserBloc(
              context.read<UserRepository>(),
              context.read<TimerBloc>(),
            )..add(const UserInitialed()),
          ),
          BlocProvider<MessageBloc>(
            create: (BuildContext context) => MessageBloc(
              context.read<MessageRepository>(),
            )..add(MessageInitilized()),
          ),
          BlocProvider<MailboxBloc>(
            create: (BuildContext context) => MailboxBloc(
              context.read<MailboxRepository>(),
            )..add(MailboxInitilized()),
          ),
          BlocProvider<DiscussNetworkBloc>(
            create: (BuildContext context) => DiscussNetworkBloc(
              context.read<DiscussNetworkRepository>(),
            )..add(DiscussNetworkInitilized()),
          ),
          BlocProvider<MeetingBloc>(
            create: (BuildContext context) => MeetingBloc(
                context.read<MeetingRepository>(), localDataProvider)
              ..add(MeetingInitilized()),
          ),
          BlocProvider<GuanduHistoricalClueBloc>(
            create: (BuildContext context) => GuanduHistoricalClueBloc(
              context.read<GuanduHistoricalClueRepository>(),
            ),
          ),
          BlocProvider<PostsBloc>(
              create: (BuildContext context) => PostsBloc(
                    context.read<PostRepository>(),
                  )..add(PostInitilized())),
          BlocProvider<OpinionBloc>(
              create: (BuildContext context) =>
                  OpinionBloc(context.read<OpinionRepository>())
                    ..add(OpinionInitilized())),
          BlocProvider<AppSettingBloc>(
            lazy: false,
            create: (BuildContext context) =>
                AppSettingBloc(context.read<AppSettingRepository>())
                  ..add(AppSettingInitlized()),
          ),
          BlocProvider<ProposalBloc>(
            create: (BuildContext context) =>
                ProposalBloc(context.read<ProposalRepository>())
                  ..add(ProposalInitialied()),
          ),
          BlocProvider<NoticeBloc>(
            create: (BuildContext context) =>
                NoticeBloc(context.read<NoticeRepository>())
                  ..add(NoticeInitialized()),
          ),
          BlocProvider<ContactBloc>(
            create: (BuildContext context) =>
                ContactBloc(context.read<ContactRepository>())
                  ..add(ContactInitialized()),
          ),
          BlocProvider<TwoMeetingsBloc>(
            create: (BuildContext context) =>
                TwoMeetingsBloc(context.read<TwoMeetingsRepository>())
                  ..add(TwoMeetingsInitilized()),
          ),
        ],
        child: CppccApp(navigationService),
      ),
    ));
    FlutterNativeSplash.remove();
  });
}
