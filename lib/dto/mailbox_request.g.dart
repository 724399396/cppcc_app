// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddMailRequest _$AddMailRequestFromJson(Map<String, dynamic> json) =>
    AddMailRequest(
      type: json['type'] as String,
      isOpen: json['isOpen'] as String,
      userId: json['userId'] as String,
      phone: json['phone'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      appendix: json['appendix'] as String?,
    );

Map<String, dynamic> _$AddMailRequestToJson(AddMailRequest instance) =>
    <String, dynamic>{
      'type': instance.type,
      'isOpen': instance.isOpen,
      'userId': instance.userId,
      'phone': instance.phone,
      'title': instance.title,
      'content': instance.content,
      'appendix': instance.appendix,
    };
