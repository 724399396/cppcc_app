// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionResponse _$VersionResponseFromJson(Map<String, dynamic> json) =>
    VersionResponse(
      json['version'] as String,
      json['apkUrl'] as String,
    );

Map<String, dynamic> _$VersionResponseToJson(VersionResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'apkUrl': instance.apkUrl,
    };
