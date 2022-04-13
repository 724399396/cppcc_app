import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/opinions.dart';
import 'package:cppcc_app/repository/opinion_repository.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';

part 'opinion_event.dart';
part 'opinion_state.dart';

class OpinionBloc extends Bloc<OpinionEvent, OpinionState> {
  final OpinionRepository _opinionRepository;

  OpinionBloc(this._opinionRepository) : super(const OpinionState()) {
    on<OpinionInitilized>((event, emit) async {
      await _opinionRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
      await _generateCallApi(event, emit, (emit) async {
        for (var type in OpinionListType.values) {
          Map<OpinionListType, List<Opinion>> newOpitions =
              Map.from(state.opitions);
          newOpitions[type] = [];
          Map<OpinionListType, int> newCurrentPage =
              Map.from(state.currentPage);
          newCurrentPage[type] = 1;
          emit(state.copyWith(
            currentPage: newCurrentPage,
            opitions: newOpitions,
          ));
          await _dataLoad(emit, type);
        }
      });
    });

    on<OpinionLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.type);
      });
    });

    on<OpinionRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        Map<OpinionListType, List<Opinion>> newOpitions =
            Map.from(state.opitions);
        newOpitions[event.type] = [];
        Map<OpinionListType, int> newCurrentPage = Map.from(state.currentPage);
        newCurrentPage[event.type] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          opitions: newOpitions,
        ));
        await _dataLoad(emit, event.type);
      });
    });
  }

  Future<void> _generateCallApi(OpinionEvent event, Emitter<OpinionState> emit,
      GenericApiCall<OpinionState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(
      Emitter<OpinionState> emit, OpinionListType type) async {
    var opinions = await _opinionRepository.getOpnionsList(
        state.currentPage[type] ?? 1, pageSize, type.refStatus);
    Map<OpinionListType, List<Opinion>> newOpitions = Map.from(state.opitions);
    newOpitions[type] = (newOpitions[type] ?? []) + opinions;
    Map<OpinionListType, int> newCurrentPage = Map.from(state.currentPage);
    newCurrentPage[type] = (newCurrentPage[type] ?? 1) + 1;

    emit(state.copyWith(
      currentPage: newCurrentPage,
      opitions: newOpitions,
    ));
  }

  @override
  void onChange(Change<OpinionState> change) {
    super.onChange(change);
    print(change);
  }
}
