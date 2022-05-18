import 'package:json_annotation/json_annotation.dart';

part 'discuss_network_request.g.dart';

@JsonSerializable()
class DiscussMessageSendRequest {
  final String discussNetworkId;
  final String userId;
  final String message;

  DiscussMessageSendRequest({
    required this.discussNetworkId,
    required this.userId,
    required this.message,
  });

  factory DiscussMessageSendRequest.fromJson(Map<String, dynamic> json) =>
      _$DiscussMessageSendRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussMessageSendRequestToJson(this);
}
