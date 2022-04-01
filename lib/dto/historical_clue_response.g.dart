// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_clue_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalClueWrapper _$HistoricalClueWrapperFromJson(
        Map<String, dynamic> json) =>
    HistoricalClueWrapper(
      (json['records'] as List<dynamic>)
          .map(
              (e) => HistoricalClueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..total = json['total'] as int
      ..size = json['size'] as int
      ..current = json['current'] as int
      ..pages = json['pages'] as int;

Map<String, dynamic> _$HistoricalClueWrapperToJson(
        HistoricalClueWrapper instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'pages': instance.pages,
    };

HistoricalClueResponse _$HistoricalClueResponseFromJson(
        Map<String, dynamic> json) =>
    HistoricalClueResponse()
      ..id = json['id'] as String
      ..content = json['content'] as String?
      ..createBy = json['createBy'] as String?
      ..createTime = json['createTime'] as String?
      ..phone = json['phone'] as String?
      ..title = json['title'] as String?
      ..provider = json['provider'] as String?
      ..sysOrgCode = json['sysOrgCode'] as String?
      ..unit = json['unit'] as String?
      ..updateBy = json['updateBy'] as String?
      ..updateTime = json['updateTime'] as String?;

Map<String, dynamic> _$HistoricalClueResponseToJson(
        HistoricalClueResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'phone': instance.phone,
      'title': instance.title,
      'provider': instance.provider,
      'sysOrgCode': instance.sysOrgCode,
      'unit': instance.unit,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
    };
