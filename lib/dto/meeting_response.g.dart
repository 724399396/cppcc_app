// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeetingResponse _$MeetingResponseFromJson(Map<String, dynamic> json) =>
    MeetingResponse(
      json['address'] as String?,
      json['appendix'],
      json['beginDate'] as String?,
      json['content'] as String?,
      json['createBy'] as String?,
      json['createTime'] as String?,
      json['endTime'] as String?,
      json['id'] as String,
      json['updateBy'] as String?,
      json['updateTime'] as String?,
      json['partakeUserIds'] as String?,
      json['signQrcode'] as String?,
      json['startTime'] as String?,
      json['status'] as int?,
      json['status_dictText'] as String?,
      json['title'] as String?,
      json['categoryDictText'],
      json['author'] as String?,
      json['type_dictText'] as String?,
      json['type'] as int?,
      json['hits'] as int?,
      json['read'] as bool?,
    )
      ..broadcastData = (json['broadcasts'] as List<dynamic>?)
          ?.map((e) => BroadcastsResponse.fromJson(e as Map<String, dynamic>))
          .toList()
      ..userRecords = (json['userRecords'] as List<dynamic>?)
          ?.map((e) => UserRecordsResponse.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MeetingResponseToJson(MeetingResponse instance) =>
    <String, dynamic>{
      'address': instance.address,
      'appendix': instance.appendix,
      'beginDate': instance.beginDate,
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
      'read': instance.read,
      'broadcasts': instance.broadcastData,
      'userRecords': instance.userRecords,
    };

MeetingDetailResponse _$MeetingDetailResponseFromJson(
        Map<String, dynamic> json) =>
    MeetingDetailResponse()
      ..address = json['address'] as String?
      ..appendix = json['appendix']
      ..beginDate = json['beginDate'] as String?
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
      ..hits = json['hits'] as int?
      ..broadcastData = (json['broadcasts'] as List<dynamic>?)
          ?.map((e) => BroadcastsResponse.fromJson(e as Map<String, dynamic>))
          .toList()
      ..userRecords = (json['userRecords'] as List<dynamic>?)
          ?.map((e) => UserRecordsResponse.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MeetingDetailResponseToJson(
        MeetingDetailResponse instance) =>
    <String, dynamic>{
      'address': instance.address,
      'appendix': instance.appendix,
      'beginDate': instance.beginDate,
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
      'broadcasts': instance.broadcastData,
      'userRecords': instance.userRecords,
    };

BroadcastsResponse _$BroadcastsResponseFromJson(Map<String, dynamic> json) =>
    BroadcastsResponse(
      json['id'] as String,
      json['appendix'] as String?,
      json['author'] as String?,
      json['author_dictText'] as String?,
      json['content'] as String?,
      json['createBy'] as String?,
      json['createTime'] as String?,
      json['sourceId'] as String?,
      json['sysOrgCode'] as String?,
      json['title'] as String?,
      json['type'] as int?,
      json['status_dictText'] as String?,
      json['updateBy'] as String?,
      json['updateTime'] as String?,
    );

Map<String, dynamic> _$BroadcastsResponseToJson(BroadcastsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'appendix': instance.appendix,
      'author': instance.author,
      'author_dictText': instance.authorDictText,
      'content': instance.content,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'sourceId': instance.sourceId,
      'sysOrgCode': instance.sysOrgCode,
      'title': instance.title,
      'type': instance.type,
      'status_dictText': instance.typeDictText,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
    };

UserRecordsResponse _$UserRecordsResponseFromJson(Map<String, dynamic> json) =>
    UserRecordsResponse(
      json['createBy'] as String?,
      json['createTime'] as String?,
      json['id'] as String,
      json['mettingActivityId'] as String?,
      json['mettingActivityId_dictText'] as String?,
      json['partakeType'] as int?,
      json['partakeType_dictText'] as String?,
      json['status'] as int?,
      json['status_dictText'] as String?,
      json['sysOrgCode'] as String?,
      json['updateBy'] as String?,
      json['updateTime'] as String?,
      json['userId'] as String?,
      json['userId_dictText'] as String?,
    );

Map<String, dynamic> _$UserRecordsResponseToJson(
        UserRecordsResponse instance) =>
    <String, dynamic>{
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'id': instance.id,
      'mettingActivityId': instance.mettingActivityId,
      'mettingActivityId_dictText': instance.mettingActivityIdDictText,
      'partakeType': instance.partakeType,
      'partakeType_dictText': instance.partakeTypeDictText,
      'status': instance.status,
      'status_dictText': instance.statusDictText,
      'sysOrgCode': instance.sysOrgCode,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'userId': instance.userId,
      'userId_dictText': instance.userIdDictText,
    };
