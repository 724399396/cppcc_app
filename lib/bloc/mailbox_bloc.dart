import 'package:bloc/bloc.dart';
import 'package:cppcc_app/dto/mailbox_response.dart';
import 'package:cppcc_app/repository/mailbox_repository.dart';
import 'package:equatable/equatable.dart';

part 'mailbox_event.dart';
part 'mailbox_state.dart';

class MailboxBloc extends Bloc<MailboxEvent, MailboxState> {
  final MailboxRepository _mailboxRepository;

  MailboxBloc(this._mailboxRepository) : super(const MailboxState()) {
    on<MailboxEvent>((event, emit) {
      // TODO: implement event handler
    });

    //请求获取列表数据
    on<GetMailboxListData>((event, emit) async {
      await _mailboxRepository
          .getListPage(event.pageNo, event.pageSize, event.mailBoxType)
          .then((result) {
        emit(_populateMessageData(result));
      });
    });
  }

  @override
  void onChange(Change<MailboxState> change) {
    super.onChange(change);
  }

  _populateMessageData(MailboxResponseWrapper result) {
    return state.copyWith(result.current, result);
  }
}
