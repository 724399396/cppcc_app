import 'package:cppcc_app/bloc/discuss_network_bloc.dart';
import 'package:cppcc_app/bloc/historical_clue_bloc.dart';
import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/bloc/message_bloc.dart';
import 'package:cppcc_app/bloc/news_bloc.dart';
import 'package:cppcc_app/bloc/news_topic_bloc.dart';
import 'package:cppcc_app/bloc/posts_bloc.dart';
import 'package:cppcc_app/bloc/timer_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/repository/api_provider.dart';
import 'package:cppcc_app/repository/discuss_network_repository.dart';
import 'package:cppcc_app/repository/historical_clue_repository.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';
import 'package:cppcc_app/repository/mailbox_repository.dart';
import 'package:cppcc_app/repository/meeting_repository.dart';
import 'package:cppcc_app/repository/post_repository.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/navigation_service.dart';
import 'package:cppcc_app/utils/time_ago_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:timeago/timeago.dart' as timeago;

//用户登录
import 'package:cppcc_app/repository/user_repository.dart';

//消息
import 'package:cppcc_app/repository/message_repository.dart';

//资讯
import 'package:cppcc_app/repository/news_repository.dart';

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
        // TODO replace
        baseUrl: 'https://cppcc.lingrit.com/cppcc-boot/',
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
        RepositoryProvider<MessageRepository>(
          create: (context) => MessageRepository(apiDataProvider),
        ),
        RepositoryProvider<NewsRepository>(
          create: (context) => NewsRepository(apiDataProvider),
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
        RepositoryProvider<HistoricalClueRepository>(
          create: (context) => HistoricalClueRepository(apiDataProvider),
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
            ),
          ),
          BlocProvider<NewsTopicBloc>(
            lazy: true,
            create: (BuildContext context) => NewsTopicBloc(
              context.read<NewsRepository>(),
            )..add(const NewsTopicInitialed()),
          ),
          BlocProvider<NewsBloc>(
            create: (BuildContext context) => NewsBloc(
              context.read<NewsRepository>(),
            ),
          ),
          BlocProvider<MailboxBloc>(
            create: (BuildContext context) => MailboxBloc(
              context.read<MailboxRepository>(),
            ),
          ),
          BlocProvider<DiscussNetworkBloc>(
            create: (BuildContext context) => DiscussNetworkBloc(
              context.read<DiscussNetworkRepository>(),
            ),
          ),
          BlocProvider<MeetingBloc>(
            create: (BuildContext context) => MeetingBloc(
              context.read<MeetingRepository>(),
            ),
          ),
          BlocProvider<HistoricalClueBloc>(
            create: (BuildContext context) => HistoricalClueBloc(
              context.read<HistoricalClueRepository>(),
            ),
          ),
          BlocProvider<PostsBloc>(
              create: (BuildContext context) => PostsBloc(
                    context.read<PostRepository>(),
                  )..add(PostInitilized())),
        ],
        child: CppccApp(navigationService),
      ),
    ));
    FlutterNativeSplash.remove();
  });
}
