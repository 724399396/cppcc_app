import 'package:json_annotation/json_annotation.dart';

part 'message_response.g.dart';

@JsonSerializable()
class SystemMessageResponse {
  final String id;
  final String? sendTime;
  final String titile;
  final String? msgContent;
  final String msgCategory;
  final bool? read;

  SystemMessageResponse(this.id, this.sendTime, this.titile, this.msgContent,
      this.msgCategory, this.read);

  factory SystemMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SystemMessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SystemMessageResponseToJson(this);

  static List<SystemMessageResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => SystemMessageResponse.fromJson(e)).toList();
}

@JsonSerializable()
class BusinessCardMessageResponse {
  final String id;
  final String createTime;
  @JsonKey(name: "sendUser_dictText")
  final String sendUserDictText;
  final String message;
  final bool? read;

  BusinessCardMessageResponse(
      this.id, this.createTime, this.sendUserDictText, this.message, this.read);

  factory BusinessCardMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$BusinessCardMessageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BusinessCardMessageResponseToJson(this);

  static List<BusinessCardMessageResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => BusinessCardMessageResponse.fromJson(e)).toList();
}
