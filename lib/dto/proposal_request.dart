import 'package:json_annotation/json_annotation.dart';

part 'proposal_request.g.dart';

@JsonSerializable()
class ProposalAddRequest {
  final String title;
  final String type;
  final String content;
  final String authorUser;
  final int year;
  final String? jointlyUsers;
  @JsonKey(name: 'workUtil')
  final String workUnit;
  ProposalAddRequest({
    required this.title,
    required this.type,
    required this.content,
    required this.authorUser,
    required this.jointlyUsers,
    required this.workUnit,
    required this.year,
  });

  factory ProposalAddRequest.fromJson(Map<String, dynamic> json) =>
      _$ProposalAddRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ProposalAddRequestToJson(this);
}
