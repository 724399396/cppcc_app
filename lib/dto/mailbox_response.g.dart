// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mailbox_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MailboxResponseWrapper _$MailboxResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    MailboxResponseWrapper(
      (json['records'] as List<dynamic>)
          .map((e) => MailboxResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..total = json['total'] as int
      ..size = json['size'] as int
      ..current = json['current'] as int
      ..pages = json['pages'] as int;

Map<String, dynamic> _$MailboxResponseWrapperToJson(
        MailboxResponseWrapper instance) =>
    <String, dynamic>{
      'records': instance.records,
      'total': instance.total,
      'size': instance.size,
      'current': instance.current,
      'pages': instance.pages,
    };

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
    };
