// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discuss_network_change_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscussNetworkChangeResponse _$DiscussNetworkChangeResponseFromJson(
        Map<String, dynamic> json) =>
    DiscussNetworkChangeResponse(
      json['type'] as int,
      json['userRealname'] as String?,
      json['thumbUpCount'] as int?,
      json['thumbUpUserId'] as String?,
      json['sourceId'] as String?,
      json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DiscussNetworkChangeResponseToJson(
        DiscussNetworkChangeResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'userRealname': instance.userRealname,
      'thumbUpCount': instance.thumbUpCount,
      'thumbUpUserId': instance.thumbUpUserId,
      'sourceId': instance.sourceId,
      'data': instance.data,
    };
