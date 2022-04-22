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
    HistoricalClueResponse(
      json['id'] as String,
      json['content'] as String?,
      json['createBy'] as String?,
      json['createTime'] as String?,
      json['phone'] as String?,
      json['title'] as String?,
      json['provider'] as String?,
      json['sysOrgCode'] as String?,
      json['unit'] as String?,
      json['updateBy'] as String?,
      json['updateTime'] as String?,
      json['read'] as bool?,
    );

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
      'read': instance.read,
    };
