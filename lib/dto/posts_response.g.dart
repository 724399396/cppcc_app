// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsResponseWrapper _$PostsResponseWrapperFromJson(
        Map<String, dynamic> json) =>
    PostsResponseWrapper(
      (json['records'] as List<dynamic>)
          .map((e) => PostsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostsResponseWrapperToJson(
        PostsResponseWrapper instance) =>
    <String, dynamic>{
      'records': instance.records,
    };

PostsResponse _$PostsResponseFromJson(Map<String, dynamic> json) =>
    PostsResponse(
      json['id'] as String,
      json['title'] as String,
      json['cover'] as String?,
      json['content'] as String?,
      json['hits'] as int?,
      json['appendix'] as String?,
      json['author'] as String?,
      json['category'] as int?,
      json['type'] as int?,
      json['createBy'] as String,
      json['createTime'] as String,
    );

Map<String, dynamic> _$PostsResponseToJson(PostsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'cover': instance.cover,
      'content': instance.content,
      'hits': instance.hits,
      'appendix': instance.appendix,
      'author': instance.author,
      'category': instance.category,
      'type': instance.type,
      'createBy': instance.createBy,
      'createTime': instance.createTime,
    };
