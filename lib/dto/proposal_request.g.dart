// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProposalAddRequest _$ProposalAddRequestFromJson(Map<String, dynamic> json) =>
    ProposalAddRequest(
      title: json['title'] as String,
      type: json['type'] as String,
      content: json['content'] as String,
      authorUser: json['authorUser'] as String,
      jointlyUsers: json['jointlyUsers'] as String?,
      workUnit: json['workUtil'] as String,
      year: json['year'] as int,
    );

Map<String, dynamic> _$ProposalAddRequestToJson(ProposalAddRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'content': instance.content,
      'authorUser': instance.authorUser,
      'year': instance.year,
      'jointlyUsers': instance.jointlyUsers,
      'workUtil': instance.workUnit,
    };
