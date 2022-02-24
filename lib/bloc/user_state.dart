part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool isLogin;
  final String? username;
  final String? nickname;
  final String? avatar;
  final FormStatus? status;
  final SuccessCallback? successCallback;
  const UserState({
    this.isLogin = false,
    this.username = '',
    this.nickname,
    this.avatar,
    this.status,
    this.successCallback,
  });

  UserState copyWith({
    bool? isLogin,
    String? username,
    String? nickname,
    String? avatar,
    FormStatus? status,
    SuccessCallback? successCallback,
  }) {
    return UserState(
      isLogin: isLogin ?? this.isLogin,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      status: status ?? this.status,
      successCallback: successCallback ?? this.successCallback,
    );
  }

  @override
  String toString() {
    return 'UserState(isLogin: $isLogin, username: $username, nickname: $nickname, avatar: $avatar, status: $status, successCallback: $successCallback)';
  }

  @override
  List<Object> get props {
    return [
      isLogin,
      username ?? '',
      nickname ?? '',
      avatar ?? '',
      status ?? '',
      successCallback ?? '',
    ];
  }
}
