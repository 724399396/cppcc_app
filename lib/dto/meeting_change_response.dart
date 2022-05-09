import 'package:json_annotation/json_annotation.dart';

part 'meeting_change_response.g.dart';

@JsonSerializable()
class MeetingChangeResponse {
  final int type;
  final String? userId;
  final String? username;
  final String? title;
  final String? content;
  final String? userRealname;
  final Map<String, dynamic>? data;

  MeetingChangeResponse(this.type, this.userId, this.username, this.title,
      this.content, this.data, this.userRealname);

  factory MeetingChangeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeetingChangeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingChangeResponseToJson(this);
}
