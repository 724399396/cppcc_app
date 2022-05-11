// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opinion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpinionResponse _$OpinionResponseFromJson(Map<String, dynamic> json) =>
    OpinionResponse(
      json['id'] as String,
      json['title'] as String,
      json['content'] as String?,
      json['authorUser_dictText'] as String?,
      json['status'] as int?,
      json['status_dictText'] as String?,
      json['type_dictText'] as String?,
      json['createTime'] as String,
      json['read'] as bool?,
      json['createBy'] as String,
    );

Map<String, dynamic> _$OpinionResponseToJson(OpinionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorUser_dictText': instance.authorUserDictText,
      'status': instance.status,
      'status_dictText': instance.statusDictText,
      'type_dictText': instance.typeDictText,
      'createTime': instance.createTime,
      'createBy': instance.createBy,
      'read': instance.read,
    };
