import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String? token;
  final UserResponse userInfo;

  LoginResponse(this.token, this.userInfo);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserResponse {
  late String username;
  late String realname;
  late String? avatar;
  late String? phone = "";
  late String? post = "";
  late String? company = "";
  late String? idCard = "";

  UserResponse(this.username, this.realname, this.avatar, this.phone, this.post,
      this.company, this.idCard);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
