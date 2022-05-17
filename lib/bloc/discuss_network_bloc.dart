import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/discuss_network.dart';
import 'package:cppcc_app/repository/discuss_network_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:collection/collection.dart';

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
    });

    on<DiscussNetworkLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.type);
      });
    });

    on<DiscussNetworkFirstFetch>((event, emit) async {
      if (!state.currentPage.containsKey(event.type)) {
        await _generateCallApi(event, emit, (emit) async {
          await _dataLoad(emit, event.type);
        });
      }
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

    on<DiscussNetworkRead>((event, emit) async {
      await _discussNetworkRepository
          .getDiscussNetworkDetail(event.discussNetwork.id);
      Map<DiscussNetworkListType, List<DiscussNetwork>> newData =
          Map.from(state.data);
      int unreadCount = state.unreadCount;
      for (var key in newData.keys) {
        var opinions = newData[key];
        var readDiscussNetwork = newData[key]
            ?.firstWhereOrNull((post) => post.id == event.discussNetwork.id);
        if (readDiscussNetwork != null && !readDiscussNetwork.read) {
          newData[key] = (opinions
                      ?.where(
                          (element) => element.id != event.discussNetwork.id)
                      .toList() ??
                  []) +
              [
                readDiscussNetwork.copyWith(read: true),
              ];
          unreadCount = unreadCount - 1;
        }
      }
      emit(state.copyWith(data: newData, unreadCount: unreadCount));
    });

    on<DicusssNetworkMsgLike>((event, emit) async {
      emit(state.copyWith(submitStatus: FormStatus.submissionInProgress));
      try {
        await _discussNetworkRepository.userLike(event.id, event.type);
        emit(state.copyWith(submitStatus: FormStatus.submissionSuccess));
        event.successCallback();
      } catch (err) {
        debugPrint('discuss network api error: $err');
        emit(state.copyWith(submitStatus: FormStatus.submissionFailure));
      }
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
