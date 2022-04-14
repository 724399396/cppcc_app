import 'package:bloc/bloc.dart';
import 'package:cppcc_app/dto/discuss_network_response.dart';
import 'package:cppcc_app/repository/discuss_network_repository.dart';
import 'package:equatable/equatable.dart';

part 'discuss_network_event.dart';
part 'discuss_network_state.dart';

class DiscussNetworkBloc
    extends Bloc<DiscussNetworkEvent, DiscussNetworkState> {
  final DiscussNetworkRepository _discussNetworkRepository;

  DiscussNetworkBloc(this._discussNetworkRepository)
      : super(const DiscussNetworkState()) {
    on<DiscussNetworkEvent>((event, emit) {
      // TODO: implement event handler
    });

    //请求获取列表数据
    on<GetDiscussNetworkData>((event, emit) async {
      await _discussNetworkRepository
          .getListPage(event.pageNo, event.pageSize, event.status)
          .then((result) {
        emit(_populateMessageData(result));
      });
    });
  }

  @override
  void onChange(Change<DiscussNetworkState> change) {
    super.onChange(change);
  }

  _populateMessageData(DiscussNetworkResponseWrapper result) {
    return state.copyWith(result.current, result);
  }
}
