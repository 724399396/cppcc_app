// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discuss_network_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscussNetworkResponse _$DiscussNetworkResponseFromJson(
        Map<String, dynamic> json) =>
    DiscussNetworkResponse(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String?,
      json['discussMsgs'] as String?,
      json['status'] as int?,
      json['status_dictText'] as String?,
      json['praiseCount'] as int?,
      json['beginDate'] as String?,
      json['endDate'] as String?,
      json['createBy'] as String,
      json['createTime'] as String,
      json['updateBy'] as String?,
      json['updateTime'] as String?,
      json['cover'] as String?,
      (json['partInUsers'] as List<dynamic>?)
          ?.map((e) => PartUsersResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['discussMessages'] as List<dynamic>?)
          ?.map((e) =>
              DiscussMessagesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['read'] as bool?,
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
      'praiseCount': instance.praiseCount,
      'beginDate': instance.beginDate,
      'endDate': instance.endDate,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
      'cover': instance.cover,
      'read': instance.read,
      'partInUsers': instance.users,
      'discussMessages': instance.discussMessages,
    };

DiscussMessagesResponse _$DiscussMessagesResponseFromJson(
        Map<String, dynamic> json) =>
    DiscussMessagesResponse(
      json['id'] as String,
      json['message'] as String?,
      json['ownerName'] as String?,
      json['ownerAvatar'] as String?,
      json['parentMsgId'] as String?,
      json['praiseCount'] as int?,
      json['userId'] as String?,
      json['createBy'] as String?,
      json['createTime'] as String?,
      json['updateBy'] as String?,
      json['updateTime'] as String?,
    );

Map<String, dynamic> _$DiscussMessagesResponseToJson(
        DiscussMessagesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'ownerName': instance.ownerName,
      'ownerAvatar': instance.ownerAvatar,
      'parentMsgId': instance.parentMsgId,
      'praiseCount': instance.praiseCount,
      'userId': instance.userId,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'updateBy': instance.updateBy,
      'updateTime': instance.updateTime,
    };

PartUsersResponse _$PartUsersResponseFromJson(Map<String, dynamic> json) =>
    PartUsersResponse(
      json['company'] as String?,
      json['createBy'] as String?,
      json['id'] as String,
      json['idCard'] as String?,
      json['phone'] as String?,
      json['post'] as String?,
      json['realname'] as String?,
      json['telephone'] as String?,
      json['updateBy'] as String?,
      json['username'] as String?,
    );

Map<String, dynamic> _$PartUsersResponseToJson(PartUsersResponse instance) =>
    <String, dynamic>{
      'company': instance.company,
      'createBy': instance.createBy,
      'id': instance.id,
      'idCard': instance.idCard,
      'phone': instance.phone,
      'post': instance.post,
      'realname': instance.realname,
      'telephone': instance.telephone,
      'updateBy': instance.updateBy,
      'username': instance.username,
    };
