part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool isLogin;
  final Contact? userInfo;

  final FormStatus? status;
  final SuccessCallback? successCallback;
  const UserState({
    this.isLogin = false,
    this.userInfo,
    this.status,
    this.successCallback,
  });

  UserState copyWith({
    bool? isLogin,
    Contact? userInfo,
    FormStatus? status,
    SuccessCallback? successCallback,
  }) {
    return UserState(
      isLogin: isLogin ?? this.isLogin,
      userInfo: userInfo ?? this.userInfo,
      status: status ?? this.status,
      successCallback: successCallback ?? this.successCallback,
    );
  }

  @override
  String toString() {
    return 'UserState(isLogin: $isLogin, userInfo: $userInfo, status: $status, successCallback: $successCallback)';
  }

  @override
  List<Object> get props => [isLogin, userInfo ?? 0, status ?? 0, successCallback ?? 0];
}
