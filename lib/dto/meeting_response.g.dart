// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingWrapper _$MeetingWrapperFromJson(Map<String, dynamic> json) =>
    MeetingWrapper(
      (json['records'] as List<dynamic>)
          .map((e) => MeetingResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..total = json['total'] as int
      ..size = json['size'] as int
      ..current = json['current'] as int
      ..pages = json['pages'] as int;

Map<String, dynamic> _$MeetingWrapperToJson(MeetingWrapper instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'pages': instance.pages,
    };

MeetingResponse _$MeetingResponseFromJson(Map<String, dynamic> json) =>
    MeetingResponse()
      ..appendix = json['appendix']
      ..categoryDictText = json['categoryDictText']
      ..author = json['author'] as String?
      ..typeDicttext = json['type_dictText'] as String?
      ..updateTime = json['updateTime'] as String?
      ..type = json['type'] as int?
      ..title = json['title'] as String?
      ..content = json['content'] as String?
      ..cover = json['cover'] as String?
      ..hits = json['hits'] as int?
      ..createBy = json['createBy'] as String?
      ..createTime = json['createTime'] as String?
      ..updateBy = json['updateBy'] as String?
      ..id = json['id'] as String
      ..category = json['category'] as int?;

Map<String, dynamic> _$MeetingResponseToJson(MeetingResponse instance) =>
    <String, dynamic>{
      'appendix': instance.appendix,
      'categoryDictText': instance.categoryDictText,
      'author': instance.author,
      'type_dictText': instance.typeDicttext,
      'updateTime': instance.updateTime,
      'type': instance.type,
      'title': instance.title,
      'content': instance.content,
      'cover': instance.cover,
      'hits': instance.hits,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'updateBy': instance.updateBy,
      'id': instance.id,
      'category': instance.category,
    };
