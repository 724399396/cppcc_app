import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String token;
  final UserResponse userInfo;
  final List<DictItem> dictData;

  LoginResponse(this.token, this.userInfo, this.dictData);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserInfoResponse {
  final UserResponse userInfo;

  UserInfoResponse(this.userInfo);

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
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

@JsonSerializable()
class DictItem {
  late String id;
  late String dictCode;
  late String itemValue;
  late String dictName;
  late String itemText;

  DictItem();

  factory DictItem.fromJson(Map<String, dynamic> json) =>
      _$DictItemFromJson(json);
  Map<String, dynamic> toJson() => _$DictItemToJson(this);
}

@JsonSerializable()
class DictItemEntity {
  List<DictItem> dictData;

  DictItemEntity(this.dictData);

  factory DictItemEntity.fromJson(Map<String, dynamic> json) =>
      _$DictItemEntityFromJson(json);
  Map<String, dynamic> toJson() => _$DictItemEntityToJson(this);
}
