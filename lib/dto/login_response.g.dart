// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      json['token'] as String,
      UserResponse.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userInfo': instance.userInfo,
    };

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      UserResponse.fromJson(json['userInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'userInfo': instance.userInfo,
    };

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['id'] as String,
      json['username'] as String,
      json['realname'] as String,
      json['avatar'] as String?,
      json['phone'] as String?,
      json['post'] as String?,
      json['post_dictText'] as String?,
      json['company'] as String?,
      json['idCard'] as String?,
      json['wxQrcode'] as String?,
      json['position'] as String,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'realname': instance.realname,
      'avatar': instance.avatar,
      'phone': instance.phone,
      'post': instance.post,
      'post_dictText': instance.postDictText,
      'company': instance.company,
      'idCard': instance.idCard,
      'wxQrcode': instance.wxQrCode,
      'position': instance.position,
    };

DictItem _$DictItemFromJson(Map<String, dynamic> json) => DictItem()
  ..id = json['id'] as String
  ..dictCode = json['dictCode'] as String
  ..itemValue = json['itemValue'] as String
  ..dictName = json['dictName'] as String
  ..itemText = json['itemText'] as String;

Map<String, dynamic> _$DictItemToJson(DictItem instance) => <String, dynamic>{
      'id': instance.id,
      'dictCode': instance.dictCode,
      'itemValue': instance.itemValue,
      'dictName': instance.dictName,
      'itemText': instance.itemText,
    };

DictItemEntity _$DictItemEntityFromJson(Map<String, dynamic> json) =>
    DictItemEntity(
      (json['dictData'] as List<dynamic>)
          .map((e) => DictItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DictItemEntityToJson(DictItemEntity instance) =>
    <String, dynamic>{
      'dictData': instance.dictData,
    };
