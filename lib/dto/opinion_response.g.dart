// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opinion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpinionResponseWrapper _$OpinionResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    OpinionResponseWrapper(
      (json['records'] as List<dynamic>)
          .map((e) => OpinionResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OpinionResponseWrapperToJson(
        OpinionResponseWrapper instance) =>
    <String, dynamic>{
      'records': instance.records,
    };

OpinionResponse _$OpinionResponseFromJson(Map<String, dynamic> json) =>
    OpinionResponse(
      json['id'] as String,
      json['title'] as String,
      json['content'] as String?,
      json['authorUserDictText'] as String?,
      json['status'] as int?,
      json['typeDictText'] as String?,
      json['createTime'] as String,
    );

Map<String, dynamic> _$OpinionResponseToJson(OpinionResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'authorUserDictText': instance.authorUserDictText,
      'status': instance.status,
      'typeDictText': instance.typeDictText,
      'createTime': instance.createTime,
    };
