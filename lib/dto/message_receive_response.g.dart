// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_receive_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageReceiveResponse _$MessageReceiveResponseFromJson(
        Map<String, dynamic> json) =>
    MessageReceiveResponse(
      json['type'] as int,
      json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$MessageReceiveResponseToJson(
        MessageReceiveResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'data': instance.data,
    };
