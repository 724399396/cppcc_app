// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dict_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DictResponse _$DictResponseFromJson(Map<String, dynamic> json) => DictResponse(
      json['dictCode'] as String,
      json['itemValue'] as String,
      json['itemText'] as String,
    );

Map<String, dynamic> _$DictResponseToJson(DictResponse instance) =>
    <String, dynamic>{
      'dictCode': instance.dictCode,
      'itemValue': instance.itemValue,
      'itemText': instance.itemText,
    };
