import 'package:json_annotation/json_annotation.dart';

part 'meeting_response.g.dart';

@JsonSerializable()
class MeetingWrapper {
  final List<MeetingResponse> records;
  late int total;
  late int size;
  late int current;
  late int pages;

  MeetingWrapper(this.records);

  factory MeetingWrapper.fromJson(Map<String, dynamic> json) =>
      _$MeetingWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingWrapperToJson(this);
}

@JsonSerializable()
class MeetingResponse {
  late String? address;
  late dynamic appendix;
  late String? beginDate;
  late String? content;
  late String? createBy;
  late String? createTime;
  late String? endTime;
  late String id;
  late String? updateBy;
  late String? updateTime;
  late String? partakeUserIds;
  late String? signQrcode;
  late String? startTime;
  late int? status;
  @JsonKey(name: "status_dictText")
  late String? statusDictText;
  late String? title;
  late dynamic categoryDictText;
  late String? author;
  @JsonKey(name: "type_dictText")
  late String? typeDicttext;
  late int? type;
  late int? hits;

  @JsonKey(name: 'broadcasts')
  late List<BroadcastsResponse>? broadcastData;

  @JsonKey(name: 'userRecords')
  late List<UserRecordsResponse>? userRecords;

  MeetingResponse();

  factory MeetingResponse.fromJson(Map<String, dynamic> json) =>
      _$MeetingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingResponseToJson(this);
}

@JsonSerializable()
class BroadcastsResponse {
  final String id; //"1505753376842088449"
  final String? appendix;
  final String? author; //"1501143094266204161"
  @JsonKey(name: "author_dictText")
  final String? authorDictText; //"符佳羽"
  final String? content; //"<p>大众创业，万众创新</p>"
  final String? createBy; //"admin"
  final String? createTime; //"2022-03-21 11:49:15"
  final String? sourceId; //"1504342305598099457"
  final String? sysOrgCode; //"A02"
  final String? title; //"大众创业，万众创新"
  final int? type; //3
  @JsonKey(name: "status_dictText")
  final String? typeDictText; //"会议播报"
  final String? updateBy;
  final String? updateTime;

  BroadcastsResponse(
      this.id,
      this.appendix,
      this.author,
      this.authorDictText,
      this.content,
      this.createBy,
      this.createTime,
      this.sourceId,
      this.sysOrgCode,
      this.title,
      this.type,
      this.typeDictText,
      this.updateBy,
      this.updateTime);

  factory BroadcastsResponse.fromJson(Map<String, dynamic> json) =>
      _$BroadcastsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BroadcastsResponseToJson(this);
}

@JsonSerializable()
class UserRecordsResponse {
  final String? createBy; //"admin"
  final String? createTime; //"2022-03-23 15:30:17"
  final String id; //"1506533776600928257"
  final String? mettingActivityId; //"1504342305598099457"
  @JsonKey(name: "mettingActivityId_dictText")
  final String? mettingActivityIdDictText; //"全国政协召开“推动大众创业、万众创新”专题协商会"
  final int? partakeType; //2
  @JsonKey(name: "partakeType_dictText")
  final String? partakeTypeDictText; //"接受邀请"
  final int? status;
  @JsonKey(name: "status_dictText")
  final String? statusDictText;
  final String? sysOrgCode; //"A02"
  final String? updateBy;
  final String? updateTime;
  final String? userId;
  @JsonKey(name: "userId_dictText")
  final String? userIdDictText;

  UserRecordsResponse(
      this.createBy,
      this.createTime,
      this.id,
      this.mettingActivityId,
      this.mettingActivityIdDictText,
      this.partakeType,
      this.partakeTypeDictText,
      this.status,
      this.statusDictText,
      this.sysOrgCode,
      this.updateBy,
      this.updateTime,
      this.userId,
      this.userIdDictText);

  factory UserRecordsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRecordsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserRecordsResponseToJson(this);
}
