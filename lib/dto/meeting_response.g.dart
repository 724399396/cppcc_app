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
      ..address = json['address'] as String?
      ..appendix = json['appendix']
      ..beginDate = json['beginDate'] as String?
      ..broadcasts = json['broadcasts'] as String?
      ..content = json['content'] as String?
      ..createBy = json['createBy'] as String?
      ..createTime = json['createTime'] as String?
      ..endTime = json['endTime'] as String?
      ..id = json['id'] as String
      ..updateBy = json['updateBy'] as String?
      ..updateTime = json['updateTime'] as String?
      ..partakeUserIds = json['partakeUserIds'] as String?
      ..signQrcode = json['signQrcode'] as String?
      ..startTime = json['startTime'] as String?
      ..status = json['status'] as int?
      ..statusDictText = json['status_dictText'] as String?
      ..title = json['title'] as String?
      ..categoryDictText = json['categoryDictText']
      ..author = json['author'] as String?
      ..typeDicttext = json['type_dictText'] as String?
      ..type = json['type'] as int?
      ..hits = json['hits'] as int?;

Map<String, dynamic> _$MeetingResponseToJson(MeetingResponse instance) =>
    <String, dynamic>{
      'address': instance.address,
      'appendix': instance.appendix,
      'beginDate': instance.beginDate,
      'broadcasts': instance.broadcasts,
      'content': instance.content,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'endTime': instance.endTime,
      'id': instance.id,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'partakeUserIds': instance.partakeUserIds,
      'signQrcode': instance.signQrcode,
      'startTime': instance.startTime,
      'status': instance.status,
      'status_dictText': instance.statusDictText,
      'title': instance.title,
      'categoryDictText': instance.categoryDictText,
      'author': instance.author,
      'type_dictText': instance.typeDicttext,
      'type': instance.type,
      'hits': instance.hits,
    };
