part of 'app_setting_bloc.dart';

abstract class AppSettingEvent extends Equatable {
  const AppSettingEvent();

  @override
  List<Object> get props => [];
}

class AppSettingInitlized extends AppSettingEvent {}
