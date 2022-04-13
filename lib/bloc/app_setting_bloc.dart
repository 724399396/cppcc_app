import 'package:bloc/bloc.dart';
import 'package:cppcc_app/dto/dict_response.dart';
import 'package:cppcc_app/repository/app_setting_repository.dart';
import 'package:equatable/equatable.dart';
import "package:collection/collection.dart";
import 'package:cppcc_app/models/dict.dart';

part 'app_setting_event.dart';
part 'app_setting_state.dart';

class AppSettingBloc extends Bloc<AppSettingEvent, AppSettingState> {
  final AppSettingRepository _appSettingRepository;

  AppSettingBloc(this._appSettingRepository) : super(const AppSettingState()) {
    on<AppSettingInitlized>((event, emit) async {
      await _appSettingRepository.getDict().then((dicts) {
        Map<String, List<DictResponse>> dictCodeToResponses =
            groupBy(dicts, (dict) => dict.dictCode);
        emit(state.copyWith(
            dictMap: dictCodeToResponses.map(
          (key, value) => MapEntry(
              key,
              value
                  .map(
                      (v) => Dict(itemValue: v.itemValue, itemText: v.itemText))
                  .toList()),
        )));
      });
    });
  }
}
