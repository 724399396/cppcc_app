import 'package:bloc/bloc.dart';
import 'package:cppcc_app/dto/meeting_response.dart';
import 'package:cppcc_app/repository/meeting_repository.dart';
import 'package:equatable/equatable.dart';

part 'meeting_event.dart';
part 'meeting_state.dart';

class MeetingBloc extends Bloc<MeetingEvent, MeetingState> {
  final MeetingRepository _meetingRepository;

  MeetingBloc(this._meetingRepository) : super(const MeetingState()) {
    on<MeetingEvent>((event, emit) {
      // TODO: implement event handler
    });

    //请求获取列表数据
    on<GetMeetingListData>((event, emit) async {
      await _meetingRepository
          .getListPage(event.pageNo, event.pageSize, event.type)
          .then((result) {
        emit(_populateMessageData(result));
      });
    });

    //添加
    on<AddMeeting>((event, emit) async {
    });
  }

  @override
  void onChange(Change<MeetingState> change) {
    super.onChange(change);
  }

  _populateMessageData(MeetingWrapper result) {
    return state.copyWith(result.current, result);
  }
}
