part of 'user_bloc.dart';

class UserState extends Equatable {
  final bool isLogin;
  final String? username;
  final String? nickname;
  final String? avatar;

//新加数据字段部分
  final String? phone;
  final String? post;
  final String? company;
  final String? idCard;

  final FormStatus? status;
  final SuccessCallback? successCallback;
  const UserState({
    this.isLogin = false,
    this.username = '',
    this.nickname,
    this.avatar,
    this.phone,
    this.post,
    this.company,
    this.idCard,
    this.status,
    this.successCallback,
  });

  UserState copyWith({
    bool? isLogin,
    String? username,
    String? nickname,
    String? avatar,
    String? phone,
    String? post,
    String? company,
    String? idCard,
    FormStatus? status,
    SuccessCallback? successCallback,
  }) {
    return UserState(
      isLogin: isLogin ?? this.isLogin,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      avatar: avatar ?? this.avatar,
      phone: phone ?? this.phone,
      post: post ?? this.post,
      company: company ?? this.company,
      idCard: idCard ?? this.idCard,
      status: status ?? this.status,
      successCallback: successCallback ?? this.successCallback,
    );
  }

  @override
  String toString() {
    return 'UserState(isLogin: $isLogin, username: $username, nickname: $nickname, avatar: $avatar,phone: $phone,post: $post,company: $company,idCard: $idCard, status: $status, successCallback: $successCallback)';
  }

  @override
  List<Object> get props {
    return [
      isLogin,
      username ?? '',
      nickname ?? '',
      avatar ?? '',
      phone ?? '',
      post ?? '',
      company ?? '',
      idCard ?? '',
      status ?? '',
      successCallback ?? '',
    ];
  }
}
