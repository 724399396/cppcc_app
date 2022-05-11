part of 'user_bloc.dart';

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
  final String newPassword;

  const UserUpdatePasswordRequested(
      this.newPassword, successCallback)
      : super(successCallback);

  @override
  List<Object> get props => [newPassword];
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

class UserUpdateAvatarRequested extends UserEvent {
  final XFile avatar;

  const UserUpdateAvatarRequested(this.avatar, successCallback)
      : super(successCallback);
}

class UserUpdatePhoneRequested extends UserEvent {
  final String phone;
  final String verifyCode;

  const UserUpdatePhoneRequested(
      this.phone, this.verifyCode, SuccessCallback? successCallback)
      : super(successCallback);
}

class UserUpdateWxQrCode extends UserEvent {
  final XFile image;

  const UserUpdateWxQrCode(this.image, successCallback)
      : super(successCallback);
}