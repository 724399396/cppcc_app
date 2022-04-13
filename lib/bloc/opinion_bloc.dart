import 'package:bloc/bloc.dart';
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
    });
  }
}
