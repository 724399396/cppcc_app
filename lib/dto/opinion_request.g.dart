// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opinion_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpinionAddRequest _$OpinionAddRequestFromJson(Map<String, dynamic> json) =>
    OpinionAddRequest(
      title: json['title'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      authorUser: json['authorUser'] as String,
    );

Map<String, dynamic> _$OpinionAddRequestToJson(OpinionAddRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'content': instance.content,
      'authorUser': instance.authorUser,
    };
