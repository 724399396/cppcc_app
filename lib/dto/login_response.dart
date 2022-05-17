import 'package:equatable/equatable.dart';
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
class UserResponse extends Equatable {
  final String id;
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

  const UserResponse(
      this.id,
      this.username,
      this.realname,
      this.avatar,
      this.phone,
      this.post,
      this.postDictText,
      this.company,
      this.idCard,
      this.wxQrCode,
      this.position);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  static List<UserResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => UserResponse.fromJson(e)).toList();

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  UserResponse copyWith({
    String? id,
    String? username,
    String? realname,
    String? avatar,
    String? phone,
    String? post,
    String? postDictText,
    String? company,
    String? idCard,
    String? wxQrCode,
    String? position,
  }) {
    return UserResponse(
      id ?? this.id,
      username ?? this.username,
      realname ?? this.realname,
      avatar ?? this.avatar,
      phone ?? this.phone,
      post ?? this.post,
      postDictText ?? this.postDictText,
      company ?? this.company,
      idCard ?? this.idCard,
      wxQrCode ?? this.wxQrCode,
      position ?? this.position,
    );
  }

  @override
  String toString() {
    return 'UserResponse(id: $id, username: $username, realname: $realname, avatar: $avatar, phone: $phone, post: $post, postDictText: $postDictText, company: $company, idCard: $idCard, wxQrCode: $wxQrCode, position: $position)';
  }

  @override
  List<Object> get props {
    return [
      id,
      username,
      realname,
      avatar ?? '',
      phone ?? '',
      post ?? '',
      postDictText ?? '',
      company ?? '',
      idCard ?? '',
      wxQrCode ?? '',
      position,
    ];
  }
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
class UserUpdateRequest {
  final String? avatar;
  final String? wxQrCode;

  UserUpdateRequest({this.avatar, this.wxQrCode});

  factory UserUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserUpdateRequestToJson(this);
}
