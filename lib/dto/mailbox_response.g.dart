// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailboxResponse _$MailboxResponseFromJson(Map<String, dynamic> json) =>
    MailboxResponse(
      json['id'] as String,
      json['title'] as String,
      json['content'] as String?,
      json['phone'] as String?,
      json['category'] as int?,
      json['userId'] as String?,
      json['userId_dictText'] as String?,
      json['type'] as int?,
      json['type_dictText'] as String?,
      json['createBy'] as String,
      json['createTime'] as String,
      json['read'] as bool?,
      json['handleWorkutil'] as String?,
      json['replyMessage'] as String?,
      json['handleTime'] as String?,
      json['appendix'] as String?,
    );

Map<String, dynamic> _$MailboxResponseToJson(MailboxResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'phone': instance.phone,
      'category': instance.category,
      'userId': instance.userId,
      'userId_dictText': instance.userRealname,
      'type': instance.type,
      'type_dictText': instance.typeDictText,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
      'read': instance.read,
      'handleWorkutil': instance.handleWorkunit,
      'replyMessage': instance.replyMessage,
      'handleTime': instance.handleTime,
      'appendix': instance.appendix,
    };
