import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/dto/mailbox_request.dart';
import 'package:cppcc_app/models/app_settings.dart';
import 'package:cppcc_app/models/mail.dart';
import 'package:cppcc_app/repository/mailbox_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:cppcc_app/utils/list_data_fetch_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'mailbox_event.dart';
part 'mailbox_state.dart';

class MailboxBloc extends Bloc<MailboxEvent, MailboxState> {
  final MailboxRepository _mailboxRepository;

  MailboxBloc(this._mailboxRepository) : super(const MailboxState()) {
    on<MailboxInitilized>((event, emit) async {
      await _mailboxRepository.getUnreadCount().then((count) {
        emit(state.copyWith(unreadCount: count));
      });
    });

    on<MailboxFirstFetch>((event, emit) async {
      if (!state.currentPage.containsKey(event.type)) {
        await _generateCallApi(event, emit, (emit) async {
          await _dataLoad(emit, event.type);
        });
      }
    });

    on<MailboxRefresh>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        Map<String, List<Mail>> newMailbox = Map.from(state.data);
        newMailbox[event.type] = [];
        Map<String, int> newCurrentPage = Map.from(state.currentPage);
        newCurrentPage[event.type] = 1;
        emit(state.copyWith(
          currentPage: newCurrentPage,
          data: newMailbox,
        ));
        await _dataLoad(emit, event.type);
      });
    });

    on<MailboxLoadMore>((event, emit) async {
      await _generateCallApi(event, emit, (emit) async {
        await _dataLoad(emit, event.type);
      });
    });

    on<GoMailDetail>((event, emit) async {
      Mail? currentMail = await _mailboxRepository.getMailDetail(event.id);
      Map<String, List<Mail>> newData = Map.from(state.data);
      bool found = false;
      for (var key in newData.keys) {
        newData[key] = updateWithGenerateNewList<Mail>(
          newData[key] ?? [],
          (e) => e.id == event.id,
          (e) => e?.copyWith(read: true),
          matcherCallback: (e) {
            if (!e.read) {
              found = true;
            }
          },
        );
      }
      emit(state.copyWith(
          data: newData,
          unreadCount: found ? state.unreadCount - 1 : state.unreadCount,
          currentMail: currentMail.copyWith(read: true)));
    });

    //添加领导信箱
    on<AddMailbox>((event, emit) async {
      emit(state.copyWith(submitStatus: FormStatus.submissionInProgress));
      try {
        await _mailboxRepository.addMailbox(event.request);
        emit(state.copyWith(submitStatus: FormStatus.submissionSuccess));
        event.successCallback!();
      } catch (err) {
        debugPrint('mail box api error: $err');
        emit(state.copyWith(submitStatus: FormStatus.submissionFailure));
      }
    });
  }

  Future<void> _generateCallApi(MailboxEvent event, Emitter<MailboxState> emit,
      GenericApiCall<MailboxState> call) async {
    emit(state.copyWith(status: ListDataFetchStatus.refresh));
    try {
      await call(emit);
      emit(state.copyWith(status: ListDataFetchStatus.normal));
    } catch (err) {
      debugPrint('get mailbox error: $err');
      emit(state.copyWith(status: ListDataFetchStatus.failure));
    }
  }

  Future<void> _dataLoad(Emitter<MailboxState> emit, String type) async {
    var datas = await _mailboxRepository.getListPage(
        state.currentPage[type] ?? 1, pageSize, type);
    Map<String, List<Mail>> newData = Map.from(state.data);
    newData[type] = (newData[type] ?? []) + datas;
    Map<String, int> newCurrentPage = Map.from(state.currentPage);
    newCurrentPage[type] = (newCurrentPage[type] ?? 1) + 1;

    emit(state.copyWith(
      currentPage: newCurrentPage,
      data: newData,
    ));
  }
}
