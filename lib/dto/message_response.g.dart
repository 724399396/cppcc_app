// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemMessageResponse _$SystemMessageResponseFromJson(
        Map<String, dynamic> json) =>
    SystemMessageResponse(
      json['id'] as String,
      json['sendTime'] as String?,
      json['titile'] as String,
      json['msgContent'] as String?,
      json['msgCategory'] as String,
      json['read'] as bool?,
    );

Map<String, dynamic> _$SystemMessageResponseToJson(
        SystemMessageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sendTime': instance.sendTime,
      'titile': instance.titile,
      'msgContent': instance.msgContent,
      'msgCategory': instance.msgCategory,
      'read': instance.read,
    };

BusinessCardMessageResponse _$BusinessCardMessageResponseFromJson(
        Map<String, dynamic> json) =>
    BusinessCardMessageResponse(
      json['id'] as String,
      json['createTime'] as String,
      json['sendUser_dictText'] as String,
      json['message'] as String,
      json['read'] as bool?,
    );

Map<String, dynamic> _$BusinessCardMessageResponseToJson(
        BusinessCardMessageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createTime': instance.createTime,
      'sendUser_dictText': instance.sendUserDictText,
      'message': instance.message,
      'read': instance.read,
    };
