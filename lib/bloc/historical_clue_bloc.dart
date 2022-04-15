import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/historical_clue_response.dart';
import 'package:cppcc_app/repository/historical_clue_repository.dart';
import 'package:equatable/equatable.dart';

part 'historical_clue_event.dart';
part 'historical_clue_state.dart';

class HistoricalClueBloc
    extends Bloc<HistoricalClueEvent, HistoricalClueState> {
  final HistoricalClueRepository _historicalClueRepository;

  HistoricalClueBloc(this._historicalClueRepository)
      : super(const HistoricalClueState()) {
    on<HistoricalClueEvent>((event, emit) {
      // TODO: implement event handler
    });

    //请求获取列表数据
    on<GetHistoricalClueListData>((event, emit) async {
      await _historicalClueRepository
          .getListPage(event.pageNo, event.pageSize)
          .then((result) {
        emit(_populateMessageData(result));
      });
    });

    //添加领导信箱
    on<AddHistoricalClue>((event, emit) async {
      await _historicalClueRepository
          .addHistoricalClue(event.title, event.unit!, event.provider!,
              event.phone!, event.content!)
          .then((result) {
        if (result.success) {
          event.successCallback!();
        } else {
          event.failCallback!();
        }
      });
    });
  }

  @override
  void onChange(Change<HistoricalClueState> change) {
    super.onChange(change);
  }

  _populateMessageData(HistoricalClueWrapper result) {
    return state.copyWith(result.current, result);
  }
}
