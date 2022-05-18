import 'package:json_annotation/json_annotation.dart';

part 'mailbox_response.g.dart';

@JsonSerializable()
class MailboxResponse {
  final String id;
  final String title;
  final String? content;
  late String? phone;
  final int? category;
  final String? userId;
  @JsonKey(name: 'userId_dictText')
  final String? userRealname;
  final int? type;
  @JsonKey(name: 'type_dictText')
  final String? typeDictText;
  final String createBy;
  final String createTime;
  final bool? read;
  @JsonKey(name: 'handleWorkutil')
  final String? handleWorkunit;
  final String? replyMessage;
  final String? handleTime;

  MailboxResponse(
    this.id,
    this.title,
    this.content,
    this.phone,
    this.category,
    this.userId,
    this.userRealname,
    this.type,
    this.typeDictText,
    this.createBy,
    this.createTime,
    this.read,
    this.handleWorkunit,
    this.replyMessage,
    this.handleTime,
  );

  factory MailboxResponse.fromJson(Map<String, dynamic> json) =>
      _$MailboxResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MailboxResponseToJson(this);
  static List<MailboxResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => MailboxResponse.fromJson(e)).toList();
}
