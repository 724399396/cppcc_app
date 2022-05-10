import 'package:json_annotation/json_annotation.dart';

part 'message_receive_response.g.dart';

@JsonSerializable()
class MessageReceiveResponse {
  final int type;
  final Map<String, dynamic>? data;

  MessageReceiveResponse(this.type, this.data);

  factory MessageReceiveResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageReceiveResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageReceiveResponseToJson(this);
}
