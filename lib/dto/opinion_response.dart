import 'package:json_annotation/json_annotation.dart';

part 'opinion_response.g.dart';

@JsonSerializable()
class OpinionResponseWrapper {
  final List<OpinionResponse> records;

  OpinionResponseWrapper(this.records);

  factory OpinionResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$OpinionResponseWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$OpinionResponseWrapperToJson(this);
}

@JsonSerializable()
class OpinionResponse {
  final String id;
  final String title;
  final String? content;
  final String? authorUserDictText;
  final int? status;
  final String? typeDictText;
  final String createTime;

  OpinionResponse(this.id, this.title, this.content, this.authorUserDictText,
      this.status, this.typeDictText, this.createTime);

  factory OpinionResponse.fromJson(Map<String, dynamic> json) =>
      _$OpinionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OpinionResponseToJson(this);

  static List<OpinionResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => OpinionResponse.fromJson(e)).toList();
}
