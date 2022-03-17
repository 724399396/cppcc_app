// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discuss_network_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscussNetworkResponseWrapper _$DiscussNetworkResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    DiscussNetworkResponseWrapper(
      (json['records'] as List<dynamic>)
          .map(
              (e) => DiscussNetworkResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..total = json['total'] as int
      ..size = json['size'] as int
      ..current = json['current'] as int
      ..pages = json['pages'] as int;

Map<String, dynamic> _$DiscussNetworkResponseWrapperToJson(
        DiscussNetworkResponseWrapper instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'pages': instance.pages,
    };

DiscussNetworkResponse _$DiscussNetworkResponseFromJson(
        Map<String, dynamic> json) =>
    DiscussNetworkResponse(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String?,
      json['discussMsgs'] as String?,
      json['status'] as int?,
      json['status_dictText'] as String?,
      json['partInUsers'] as String?,
      json['praiseCount'] as int?,
      json['discussFiles'],
      json['beginDate'] as String?,
      json['endDate'] as String?,
      json['createBy'] as String,
      json['createTime'] as String,
      json['updateBy'] as String?,
      json['updateTime'] as String?,
      json['cover'] as String?,
    );

Map<String, dynamic> _$DiscussNetworkResponseToJson(
        DiscussNetworkResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'discussMsgs': instance.discussMsgs,
      'status': instance.status,
      'status_dictText': instance.statusDictText,
      'partInUsers': instance.partInUsers,
      'praiseCount': instance.praiseCount,
      'discussFiles': instance.discussFiles,
      'beginDate': instance.beginDate,
      'endDate': instance.endDate,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'cover': instance.cover,
    };
