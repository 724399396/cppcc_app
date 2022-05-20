import 'package:bloc/bloc.dart';
import 'package:cppcc_app/bloc/helper.dart';
import 'package:cppcc_app/bloc/timer_bloc.dart';
import 'package:cppcc_app/dto/login_response.dart';
import 'package:cppcc_app/models/contact.dart';
import 'package:cppcc_app/repository/user_repository.dart';
import 'package:cppcc_app/utils/form_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  final TimerBloc _timerBloc;

  UserBloc(this._userRepository, this._timerBloc) : super(const UserState()) {
    on<UserInitialed>((event, emit) async {
      await _userRepository.freshUserInfo().then((userInfo) {
        emit(state.copyWith(userInfo: buildContactFromResponse(userInfo)));
      }).catchError((err) {
        debugPrint("获取用户信息错误!" + err.toString());
      });
    });
    on<UserLoginRequested>(((event, emit) =>
        _generateCallApi(event, emit, (emit) async {
          var userInfo =
              await _userRepository.login(event.username, event.password);
          emit(state.copyWith(userInfo: buildContactFromResponse(userInfo)));
        })));
    on<UserLogoutRequested>(
        ((event, emit) => _generateCallApi(event, emit, (emit) async {
              await _userRepository.logout();
            })));
    on<UserSendSmsVerifyCodeRequested>(
        ((event, emit) => _generateCallApi(event, emit, (emit) async {
              await _userRepository.sendSmsVerifyCode(event.phone);
              _timerBloc.add(const TimerStarted(duration: 60));
            })));
    on<UserUpdatePasswordRequested>(
        (event, emit) => _generateCallApi(event, emit, (emit) async {
              await _userRepository.updatePassword(event.newPassword);
            }));
    on<UserResetPasswordRequested>(
        ((event, emit) => _generateCallApi(event, emit, (emit) async {
              await _userRepository.resetPassword(
                  event.phone, event.password, event.verifyCode);
            })));
    on<UserUpdateAvatarRequested>(
        ((event, emit) => _generateCallApi(event, emit, (emit) async {
              var avatar = await _userRepository.updateAvatar(event.avatar);
              emit(state.copyWith(
                  userInfo: state.userInfo?.copyWith(avatar: avatar)));
            })));
    on<UserUpdatePhoneRequested>(
        ((event, emit) => _generateCallApi(event, emit, (emit) async {
              await _userRepository.updatePhone(event.phone, event.verifyCode);
              emit(state.copyWith(
                  userInfo: state.userInfo?.copyWith(phone: event.phone)));
            })));
    on<UserUpdateWxQrCode>(
        ((event, emit) => _generateCallApi(event, emit, (emit) async {
              var image = await _userRepository.updateWxQrCode(event.image);
              emit(state.copyWith(
                  userInfo: state.userInfo?.copyWith(wxQrCode: image)));
            })));
    on<UserFeedback>(
        ((event, emit) => _generateCallApi(event, emit, (emit) async {
              await _userRepository.feedback(
                  event.content, state.userInfo?.userId ?? '');
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
    );
  }

  Contact buildContactFromResponse(UserResponse e) {
    return Contact(
        company: e.company ?? '',
        postDictText: e.postDictText ?? '',
        phone: e.phone ?? '',
        realname: e.realname,
        avatar: e.avatar,
        username: e.username,
        wxQrCode: e.wxQrCode,
        position: e.position,
        idCard: e.idCard ?? '',
        userId: e.id);
  }

  void _generateCallApi(UserEvent event, Emitter<UserState> emit,
      GenericApiCall<UserState> call) async {
    emit(state.copyWith(status: FormStatus.submissionInProgress));
    try {
      await call(emit);
      emit(_populateUserData().copyWith(
          status: FormStatus.submissionSuccess,
          successCallback: event.successCallback));
    } catch (err) {
      debugPrint('user api error: $err');
      emit(state.copyWith(status: FormStatus.submissionFailure));
    }
  }
}
