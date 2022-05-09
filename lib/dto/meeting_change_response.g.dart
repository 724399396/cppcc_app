// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_change_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingChangeResponse _$MeetingChangeResponseFromJson(
        Map<String, dynamic> json) =>
    MeetingChangeResponse(
      json['type'] as int,
      json['userId'] as String?,
      json['username'] as String?,
      json['title'] as String?,
      json['content'] as String?,
      json['data'] as Map<String, dynamic>?,
      json['userRealname'] as String?,
    );

Map<String, dynamic> _$MeetingChangeResponseToJson(
        MeetingChangeResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'userId': instance.userId,
      'username': instance.username,
      'title': instance.title,
      'content': instance.content,
      'userRealname': instance.userRealname,
      'data': instance.data,
    };
