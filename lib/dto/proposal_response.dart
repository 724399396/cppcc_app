import 'package:cppcc_app/dto/opinion_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'proposal_response.g.dart';

@JsonSerializable()
class ProposalResponse {
  final String id;
  final String title;
  final String? authorUser;
  @JsonKey(name: 'authorUser_dictText')
  final String? authorUserDictText;
  final String? content;
  final int? status;
  @JsonKey(name: 'status_dictText')
  final String? statusDictText;
  final String createTime;
  final bool? read;
  final String? createBy;
  final int? year;

  ProposalResponse({
    required this.id,
    required this.title,
    required this.authorUser,
    required this.authorUserDictText,
    required this.content,
    required this.status,
    required this.statusDictText,
    required this.createTime,
    required this.read,
    required this.createBy,
    required this.year,
  });

  factory ProposalResponse.fromJson(Map<String, dynamic> json) =>
      _$ProposalResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProposalResponseToJson(this);

  static List<ProposalResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => ProposalResponse.fromJson(e)).toList();
}


@JsonSerializable()
class ProposalProgressResponse {
  final int type;
  @JsonKey(name: "type_dictText")
  final String typeDictText;
  final List<KeyValueResponse> content;

  ProposalProgressResponse(this.type, this.content, this.typeDictText);

  factory ProposalProgressResponse.fromJson(Map<String, dynamic> json) =>
      _$ProposalProgressResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProposalProgressResponseToJson(this);

  static List<ProposalProgressResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => ProposalProgressResponse.fromJson(e)).toList();
}
