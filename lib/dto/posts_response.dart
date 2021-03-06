import 'package:json_annotation/json_annotation.dart';

part 'posts_response.g.dart';

@JsonSerializable()
class PostsResponseWrapper {
  final List<PostsResponse> records;

  PostsResponseWrapper(this.records);

  factory PostsResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$PostsResponseWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$PostsResponseWrapperToJson(this);
}

@JsonSerializable()
class PostsResponse {
  final String id;
  final String title;
  final String? cover;
  final String? content;
  final int? hits;
  final String? appendix;
  final String? author;
  final int? category;
  final int? type;
  final String createBy;
  final String createTime;
  final bool? read;
  final List<UserReadRecordResponse>? userReadRecords;

  @JsonKey(name: "categoryDictText")
  final String? categoryDictText;

  PostsResponse(
      this.id,
      this.title,
      this.cover,
      this.content,
      this.hits,
      this.appendix,
      this.author,
      this.category,
      this.type,
      this.createBy,
      this.createTime,
      this.categoryDictText,
      this.read,
      this.userReadRecords);

  factory PostsResponse.fromJson(Map<String, dynamic> json) =>
      _$PostsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PostsResponseToJson(this);
}

@JsonSerializable()
class UserReadRecordResponse {
  @JsonKey(name: 'userId_dictText')
  final String userRealname;
  UserReadRecordResponse(this.userRealname);

  factory UserReadRecordResponse.fromJson(Map<String, dynamic> json) =>
      _$UserReadRecordResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserReadRecordResponseToJson(this);
}
