import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/discuss_network.dart';
import 'package:cppcc_app/repository/discuss_network_repository.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'discuss_network_event.dart';
part 'discuss_network_state.dart';

class DiscussNetworkBloc
    extends Bloc<DiscussNetworkEvent, DiscussNetworkState> {
  final DiscussNetworkRepository _discussNetworkRepository;

  DiscussNetworkBloc(this._discussNetworkRepository)
      : super(const DiscussNetworkState()) {
    on<DiscussNetworkInitilized>((event, emit) async {
      await _discussNetworkRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
      await _generateCallApi(event, emit, (emit) async {
        for (var type in DiscussNetworkListType.values) {
          Map<DiscussNetworkListType, List<DiscussNetwork>> newData =
              Map.from(state.data);
          newData[type] = [];
          Map<DiscussNetworkListType, int> newCurrentPage =
              Map.from(state.currentPage);
          newCurrentPage[type] = 1;
          emit(state.copyWith(
            currentPage: newCurrentPage,
            data: newData,
          ));
          await _dataLoad(emit, type);
        }
      });
    });

    on<DiscussNetworkLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.type);
      });
    });

    on<DiscussNetworkRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        Map<DiscussNetworkListType, List<DiscussNetwork>> newData =
            Map.from(state.data);
        newData[event.type] = [];
        Map<DiscussNetworkListType, int> newCurrentPage =
            Map.from(state.currentPage);
        newCurrentPage[event.type] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          data: newData,
        ));
        await _dataLoad(emit, event.type);
      });
    });
  }

  Future<void> _generateCallApi(
      DiscussNetworkEvent event,
      Emitter<DiscussNetworkState> emit,
      GenericApiCall<DiscussNetworkState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      debugPrint('get opinion error: $err');
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(
      Emitter<DiscussNetworkState> emit, DiscussNetworkListType type) async {
    var newList = await _discussNetworkRepository.getListPage(
        state.currentPage[type] ?? 1, pageSize, type.refStatus);
    Map<DiscussNetworkListType, List<DiscussNetwork>> newData =
        Map.from(state.data);
    newData[type] = (newData[type] ?? []) + newList;
    Map<DiscussNetworkListType, int> newCurrentPage =
        Map.from(state.currentPage);
    newCurrentPage[type] = (newCurrentPage[type] ?? 1) + 1;

    emit(state.copyWith(
      currentPage: newCurrentPage,
      data: newData,
    ));
  }
}
