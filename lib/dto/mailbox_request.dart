import 'package:json_annotation/json_annotation.dart';

part 'mailbox_request.g.dart';

@JsonSerializable()
class AddMailRequest {
  final String type;
  final String isOpen;
  final String userId;
  final String phone;
  final String title;
  final String content;

  AddMailRequest(
      {required this.type,
      required this.isOpen,
      required this.userId,
      required this.phone,
      required this.title,
      required this.content});

  factory AddMailRequest.fromJson(Map<String, dynamic> json) =>
      _$AddMailRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddMailRequestToJson(this);
}
