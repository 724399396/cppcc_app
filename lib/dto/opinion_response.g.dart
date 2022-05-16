// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opinion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpinionResponse _$OpinionResponseFromJson(Map<String, dynamic> json) =>
    OpinionResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String?,
      authorUser: json['authorUser'] as String?,
      authorUserDictText: json['authorUser_dictText'] as String?,
      status: json['status'] as int?,
      statusDictText: json['status_dictText'] as String?,
      typeDictText: json['type_dictText'] as String?,
      createTime: json['createTime'] as String,
      read: json['read'] as bool?,
      createBy: json['createBy'] as String,
    );

Map<String, dynamic> _$OpinionResponseToJson(OpinionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorUser': instance.authorUser,
      'authorUser_dictText': instance.authorUserDictText,
      'status': instance.status,
      'status_dictText': instance.statusDictText,
      'type_dictText': instance.typeDictText,
      'createTime': instance.createTime,
      'createBy': instance.createBy,
      'read': instance.read,
    };

KeyValueResponse _$KeyValueResponseFromJson(Map<String, dynamic> json) =>
    KeyValueResponse(
      json['title'] as String,
      json['value'] as String,
    );

Map<String, dynamic> _$KeyValueResponseToJson(KeyValueResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'value': instance.value,
    };

OpinionProgressResponse _$OpinionProgressResponseFromJson(
        Map<String, dynamic> json) =>
    OpinionProgressResponse(
      json['type'] as int,
      (json['content'] as List<dynamic>)
          .map((e) => KeyValueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['type_dictText'] as String,
    );

Map<String, dynamic> _$OpinionProgressResponseToJson(
        OpinionProgressResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'type_dictText': instance.typeDictText,
      'content': instance.content,
    };
