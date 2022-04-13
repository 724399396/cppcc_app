part of 'app_setting_bloc.dart';

class AppSettingState extends Equatable {
  final Map<String, List<Dict>> dictMap;

  const AppSettingState({this.dictMap = const {}});

  AppSettingState copyWith({
    Map<String, List<Dict>>? dictMap,
  }) {
    return AppSettingState(
      dictMap: dictMap ?? this.dictMap,
    );
  }

  @override
  String toString() => 'AppSettingState(dicts: $dictMap)';

  @override
  List<Object> get props => [dictMap];
}
