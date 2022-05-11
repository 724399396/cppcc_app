import 'package:json_annotation/json_annotation.dart';

part 'opinion_request.g.dart';

@JsonSerializable()
class OpinionAddRequest {
  final String title;
  final String type;
  final String content;
  final String authorUser;
  OpinionAddRequest(
      {required this.title, required this.type, required this.content, required this.authorUser});

  factory OpinionAddRequest.fromJson(Map<String, dynamic> json) =>
      _$OpinionAddRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OpinionAddRequestToJson(this);
}
