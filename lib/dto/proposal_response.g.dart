// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProposalResponse _$ProposalResponseFromJson(Map<String, dynamic> json) =>
    ProposalResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      authorUserDictText: json['authorUser_dictText'] as String?,
      content: json['content'] as String?,
      status: json['status'] as int?,
      statusDictText: json['status_dictText'] as String?,
      createTime: json['createTime'] as String,
      read: json['read'] as bool?,
      createBy: json['createBy'] as String?,
      year: json['year'] as int?,
    );

Map<String, dynamic> _$ProposalResponseToJson(ProposalResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'authorUser_dictText': instance.authorUserDictText,
      'content': instance.content,
      'status': instance.status,
      'status_dictText': instance.statusDictText,
      'createTime': instance.createTime,
      'read': instance.read,
      'createBy': instance.createBy,
      'year': instance.year,
    };
