// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProposalResponse _$ProposalResponseFromJson(Map<String, dynamic> json) =>
    ProposalResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      authorUser: json['authorUser'] as String?,
      authorUserDictText: json['authorUser_dictText'] as String?,
      content: json['content'] as String?,
      status: json['status'] as int?,
      statusDictText: json['status_dictText'] as String?,
      createTime: json['createTime'] as String,
      read: json['read'] as bool?,
      createBy: json['createBy'] as String?,
      year: json['year'] as int?,
      replyFiles: (json['replyFiles'] as List<dynamic>?)
          ?.map((e) => ReplyFileResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      readNum: json['readNum'] as int?,
    );

Map<String, dynamic> _$ProposalResponseToJson(ProposalResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authorUser': instance.authorUser,
      'authorUser_dictText': instance.authorUserDictText,
      'content': instance.content,
      'status': instance.status,
      'status_dictText': instance.statusDictText,
      'createTime': instance.createTime,
      'read': instance.read,
      'createBy': instance.createBy,
      'year': instance.year,
      'readNum': instance.readNum,
      'replyFiles': instance.replyFiles,
    };

ProposalProgressResponse _$ProposalProgressResponseFromJson(
        Map<String, dynamic> json) =>
    ProposalProgressResponse(
      json['type'] as int,
      (json['content'] as List<dynamic>)
          .map((e) => KeyValueResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['type_dictText'] as String,
    );

Map<String, dynamic> _$ProposalProgressResponseToJson(
        ProposalProgressResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'type_dictText': instance.typeDictText,
      'content': instance.content,
    };

ReplyFileResponse _$ReplyFileResponseFromJson(Map<String, dynamic> json) =>
    ReplyFileResponse(
      json['id'] as String,
      json['title'] as String,
      json['content'] as String,
      json['createTime'] as String?,
      json['authorId'] as String?,
      json['author_dictText'] as String?,
    );

Map<String, dynamic> _$ReplyFileResponseToJson(ReplyFileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createTime': instance.createTime,
      'authorId': instance.authorId,
      'author_dictText': instance.authorRealname,
    };
