import 'package:cppcc_app/bloc/timer_bloc.dart';
import 'package:cppcc_app/bloc/user_bloc.dart';
import 'package:cppcc_app/repository/api_provider.dart';
import 'package:cppcc_app/repository/local_data_provider.dart';
import 'package:cppcc_app/repository/user_repository.dart';
import 'package:cppcc_app/styles.dart';
import 'package:cppcc_app/utils/navigation_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
        // baseUrl: 'https://bgris.lingrit.com/',
        // baseUrl: 'http://172.10.1.202:10030/cppcc-boot/',
        baseUrl: 'http://cppcc.lingrit.com/cppcc-boot/',
        connectTimeout: 10000,
        receiveTimeout: 10000,
      )),
      localDataProvider,
      navigationService);
  await localDataProvider.init();

  // Don't allow landscape mode
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) =>
              UserRepository(localDataProvider, apiDataProvider),
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
            )..add(const UserInitialed()),
          ),
        ],
        child: CppccApp(navigationService),
      ),
    ));
    FlutterNativeSplash.remove();
  });
}
