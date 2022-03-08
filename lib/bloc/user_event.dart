part of 'user_bloc.dart';

typedef SuccessCallback = void Function();

abstract class UserEvent extends Equatable {
  final SuccessCallback? successCallback;

  const UserEvent(this.successCallback);

  @override
  List<Object> get props => [];
}

class UserInitialed extends UserEvent {
  const UserInitialed() : super(null);
}

class UserLogoutRequested extends UserEvent {
  const UserLogoutRequested() : super(null);
}

class UserLoginRequested extends UserEvent {
  final String username;
  final String password;

  const UserLoginRequested(this.username, this.password, successCallback)
      : super(successCallback);

  @override
  List<Object> get props => [username, password];
}

class UserUpdatePasswordRequested extends UserEvent {
  final String oldPassword;
  final String newPassword;

  const UserUpdatePasswordRequested(
      this.oldPassword, this.newPassword, successCallback)
      : super(successCallback);

  @override
  List<Object> get props => [oldPassword, newPassword];
}

class UserSendSmsVerifyCodeRequested extends UserEvent {
  final String phone;

  const UserSendSmsVerifyCodeRequested(this.phone, successCallback)
      : super(successCallback);

  @override
  List<Object> get props => [phone];
}

class UserResetPasswordRequested extends UserEvent {
  final String phone;
  final String password;
  final String verifyCode;

  const UserResetPasswordRequested(
      this.phone, this.password, this.verifyCode, successCallback)
      : super(successCallback);

  @override
  List<Object> get props => [phone, password, verifyCode];
}
