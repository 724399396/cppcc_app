import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:cppcc_app/bloc/app_setting_bloc.dart';
import 'package:cppcc_app/bloc/contact_bloc.dart';
import 'package:cppcc_app/bloc/discuss_network_bloc.dart';
import 'package:cppcc_app/bloc/guandu_historical_clue_bloc.dart';
import 'package:cppcc_app/bloc/mailbox_bloc.dart';
import 'package:cppcc_app/bloc/meeting_bloc.dart';
import 'package:cppcc_app/bloc/message_bloc.dart';
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
import 'package:cppcc_app/repository/scan_qr_code_repository.dart';
import 'package:cppcc_app/repository/two_meetings_repository.dart';
import 'package:cppcc_app/repository/upload_repository.dart';
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
        baseUrl: 'https://' + baseUrl,
        // baseUrl: 'http://' + baseUrl,
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
        RepositoryProvider<ScanQrCodeRepository>(
          create: (context) => ScanQrCodeRepository(apiDataProvider),
        ),
        RepositoryProvider<FileRepository>(
            create: (context) => FileRepository(apiDataProvider)),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TimerBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => TimerBloc(),
                  eventTransformer: sequential())),
          BlocProvider<UserBloc>(
              lazy: false,
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => UserBloc(
                        context.read<UserRepository>(),
                        context.read<TimerBloc>(),
                      )..add(const UserInitialed()),
                  eventTransformer: sequential())),
          BlocProvider<MessageBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => MessageBloc(
                        context.read<MessageRepository>(),
                        localDataProvider,
                      )..add(MessageInitilized()),
                  eventTransformer: sequential())),
          BlocProvider<MailboxBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => MailboxBloc(
                        context.read<MailboxRepository>(),
                      )..add(MailboxInitilized()),
                  eventTransformer: sequential())),
          BlocProvider<DiscussNetworkBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => DiscussNetworkBloc(
                        context.read<DiscussNetworkRepository>(),
                        localDataProvider,
                      )..add(DiscussNetworkInitilized()),
                  eventTransformer: sequential())),
          BlocProvider<MeetingBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => MeetingBloc(
                      context.read<MeetingRepository>(), localDataProvider)
                    ..add(MeetingInitilized()),
                  eventTransformer: sequential())),
          BlocProvider<GuanduHistoricalClueBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => GuanduHistoricalClueBloc(
                        context.read<GuanduHistoricalClueRepository>(),
                      ),
                  eventTransformer: sequential())),
          BlocProvider<PostsBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => PostsBloc(
                        context.read<PostRepository>(),
                      )..add(PostInitilized()),
                  eventTransformer: sequential())),
          BlocProvider<OpinionBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => OpinionBloc(context.read<OpinionRepository>())
                    ..add(OpinionInitilized()),
                  eventTransformer: sequential())),
          BlocProvider<AppSettingBloc>(
              lazy: false,
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => AppSettingBloc(context.read<AppSettingRepository>())
                    ..add(AppSettingInitlized()),
                  eventTransformer: sequential())),
          BlocProvider<ProposalBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => ProposalBloc(context.read<ProposalRepository>())
                    ..add(ProposalInitialied()),
                  eventTransformer: sequential())),
          BlocProvider<ContactBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => ContactBloc(context.read<ContactRepository>())
                    ..add(ContactInitialized()),
                  eventTransformer: sequential())),
          BlocProvider<TwoMeetingsBloc>(
              create: (BuildContext context) => BlocOverrides.runZoned(
                  () => TwoMeetingsBloc(context.read<TwoMeetingsRepository>())
                    ..add(TwoMeetingsInitilized()),
                  eventTransformer: sequential())),
        ],
        child: CppccApp(navigationService),
      ),
    ));
    FlutterNativeSplash.remove();
  });
}
