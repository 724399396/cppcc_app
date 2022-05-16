import 'package:json_annotation/json_annotation.dart';

part 'proposal_response.g.dart';

@JsonSerializable()
class ProposalResponse {
  final String id;
  final String title;
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
