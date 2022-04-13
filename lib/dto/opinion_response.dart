import 'package:json_annotation/json_annotation.dart';

part 'opinion_response.g.dart';

@JsonSerializable()
class OpinionResponse {
  final String id;
  final String title;
  final String? content;
  @JsonKey(name: "authorUser_dictText")
  final String? authorUserDictText;
  final int? status;
  @JsonKey(name: "status_dictText")
  final String? statusDictText;
  @JsonKey(name: "type_dictText")
  final String? typeDictText;
  final String createTime;
  final bool read;

  OpinionResponse(this.id, this.title, this.content, this.authorUserDictText,
      this.status, this.statusDictText, this.typeDictText, this.createTime, this.read);

  factory OpinionResponse.fromJson(Map<String, dynamic> json) =>
      _$OpinionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OpinionResponseToJson(this);

  static List<OpinionResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => OpinionResponse.fromJson(e)).toList();
}
