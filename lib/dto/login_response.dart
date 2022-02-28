import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String token;
  final UserResponse userInfo;

  LoginResponse(this.token, this.userInfo);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserResponse {
  final String username;
  final String realname;
  final String? avatar;

  UserResponse(this.username, this.realname, this.avatar);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
