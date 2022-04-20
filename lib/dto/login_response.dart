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
class UserInfoResponse {
  final UserResponse userInfo;

  UserInfoResponse(this.userInfo);

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}

@JsonSerializable()
class UserResponse {
  final String username;
  final String realname;
  final String? avatar;
  final String? phone;
  final String? post;
  @JsonKey(name: "post_dictText")
  final String? postDictText;
  final String? company;
  final String? idCard;
  @JsonKey(name: "wxQrcode")
  final String? wxQrCode;
  final String position;

  UserResponse(
      this.username,
      this.realname,
      this.avatar,
      this.phone,
      this.post,
      this.company,
      this.idCard,
      this.postDictText,
      this.wxQrCode,
      this.position);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  static List<UserResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => UserResponse.fromJson(e)).toList();

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
