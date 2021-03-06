import 'package:json_annotation/json_annotation.dart';

part 'opinion_response.g.dart';

@JsonSerializable()
class OpinionResponse {
  final String id;
  final String title;
  final String? content;
  final String? authorUser;
  @JsonKey(name: "authorUser_dictText")
  final String? authorUserDictText;
  final int? status;
  @JsonKey(name: "status_dictText")
  final String? statusDictText;
  @JsonKey(name: "type_dictText")
  final String? typeDictText;
  final String createTime;
  final String createBy;
  final bool? read;

  OpinionResponse({
    required this.id,
    required this.title,
    required this.content,
    required this.authorUser,
    required this.authorUserDictText,
    required this.status,
    required this.statusDictText,
    required this.typeDictText,
    required this.createTime,
    required this.read,
    required this.createBy,
  });

  factory OpinionResponse.fromJson(Map<String, dynamic> json) =>
      _$OpinionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OpinionResponseToJson(this);

  static List<OpinionResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => OpinionResponse.fromJson(e)).toList();
}

@JsonSerializable()
class KeyValueResponse {
  final String title;
  final String value;
  KeyValueResponse(this.title, this.value);

  factory KeyValueResponse.fromJson(Map<String, dynamic> json) =>
      _$KeyValueResponseFromJson(json);
  Map<String, dynamic> toJson() => _$KeyValueResponseToJson(this);
}

@JsonSerializable()
class OpinionProgressResponse {
  final int type;
  @JsonKey(name: "type_dictText")
  final String typeDictText;
  final List<KeyValueResponse> content;

  OpinionProgressResponse(this.type, this.content, this.typeDictText);

  factory OpinionProgressResponse.fromJson(Map<String, dynamic> json) =>
      _$OpinionProgressResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OpinionProgressResponseToJson(this);

  static List<OpinionProgressResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => OpinionProgressResponse.fromJson(e)).toList();
}
