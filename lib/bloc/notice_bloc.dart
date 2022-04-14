import 'package:bloc/bloc.dart';
import 'package:cppcc_app/repository/notice_repository.dart';
import 'package:equatable/equatable.dart';

part 'notice_event.dart';
part 'notice_state.dart';

class NoticeBloc extends Bloc<NoticeEvent, NoticeState> {
  final NoticeRepository _noticeRepository;

  NoticeBloc(this._noticeRepository) : super(const NoticeState()) {
    on<NoticeInitialized>((event, emit) async {
      await _noticeRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
    });
  }
}
