import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cppcc_app/repository/user_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';

part 'user_state.dart';

typedef GenericApiCall<T> = Future<T> Function();

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(const UserState()) {
    on<UserInitialed>((event, emit) async {
      _userRepository.freshUserInfo().then((_) {
        emit(_populateUserData());
      });
    });
    on<UserLoginRequested>(
        ((event, emit) => _generateCallApi(event, emit, () async {
              await _userRepository.login(event.username, event.password);
            })));
    on<UserLogoutRequested>(
        ((event, emit) => _generateCallApi(event, emit, () async {
              await _userRepository.logout();
            })));
    on<UserSendSmsVerifyCodeRequested>(
        ((event, emit) => _generateCallApi(event, emit, () async {
              await _userRepository.sendSmsVerifyCode(event.phone);
            })));
    on<UserUpdatePasswordRequested>(
        (event, emit) => _generateCallApi(event, emit, () async {
              await _userRepository.updatePassword(
                  event.oldPassword, event.newPassword);
            }));
    on<UserResetPasswordRequested>(
        ((event, emit) => _generateCallApi(event, emit, () async {
              await _userRepository.resetPassword(
                  event.phone, event.password, event.verifyCode);
            })));
  }

  @override
  void onChange(Change<UserState> change) {
    super.onChange(change);
    if (change.nextState.status == FormStatus.submissionSuccess &&
        change.nextState.successCallback != null) {
      change.nextState.successCallback!();
    }
  }

  UserState _populateUserData() {
    return state.copyWith(
        isLogin: _userRepository.isLogin,
        username: _userRepository.username,
        nickname: _userRepository.nickname,
        phone: _userRepository.phone,
        post: _userRepository.post,
        company: _userRepository.company,
        idCard: _userRepository.idCard,
        avatar: _userRepository.avatar);
  }

  void _generateCallApi<T>(
      UserEvent event, Emitter<UserState> emit, GenericApiCall<T> call) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      await call();
      emit(_populateUserData().copyWith(
          status: FormStatus.submissionSuccess,
          successCallback: event.successCallback));
    } catch (err) {
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }
}
