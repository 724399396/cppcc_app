// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_meetings_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwoMeetingsWrapper _$TwoMeetingsWrapperFromJson(Map<String, dynamic> json) =>
    TwoMeetingsWrapper(
      (json['records'] as List<dynamic>)
          .map((e) => TwoMeetingsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..total = json['total'] as int
      ..size = json['size'] as int
      ..current = json['current'] as int
      ..pages = json['pages'] as int;

Map<String, dynamic> _$TwoMeetingsWrapperToJson(TwoMeetingsWrapper instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'pages': instance.pages,
    };

TwoMeetingsResponse _$TwoMeetingsResponseFromJson(Map<String, dynamic> json) =>
    TwoMeetingsResponse(
      json['id'] as String,
      json['title'] as String,
      json['cover'] as String?,
      json['content'] as String,
      json['createAt'] as String?,
      json['hits'] as int?,
    );

Map<String, dynamic> _$TwoMeetingsResponseToJson(
        TwoMeetingsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover': instance.cover,
      'content': instance.content,
      'createAt': instance.createAt,
      'hits': instance.hits,
    };
