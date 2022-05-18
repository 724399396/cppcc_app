// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discuss_network_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DiscussMessageSendRequest _$DiscussMessageSendRequestFromJson(
        Map<String, dynamic> json) =>
    DiscussMessageSendRequest(
      discussNetworkId: json['discussNetworkId'] as String,
      userId: json['userId'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$DiscussMessageSendRequestToJson(
        DiscussMessageSendRequest instance) =>
    <String, dynamic>{
      'discussNetworkId': instance.discussNetworkId,
      'userId': instance.userId,
      'message': instance.message,
    };
