import 'package:json_annotation/json_annotation.dart';

part 'discuss_network_response.g.dart';

@JsonSerializable()
class DiscussNetworkResponseWrapper {
  final List<DiscussNetworkResponse> records;
  late int total;
  late int size;
  late int current;
  late int pages;

  DiscussNetworkResponseWrapper(this.records);

  factory DiscussNetworkResponseWrapper.fromJson(Map<String, dynamic> json) =>
      _$DiscussNetworkResponseWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussNetworkResponseWrapperToJson(this);
}

@JsonSerializable()
class DiscussNetworkResponse {
  final String id;
  final String title;
  final String? description;
  late String? discussMsgs;
  final int? status;
  @JsonKey(name: 'status_dictText')
  final String? statusDictText;
  final int? praiseCount;
  final String? beginDate;
  final String? endDate;
  final String createBy;
  final String createTime;
  final String? updateBy;
  final String? updateTime;
  final String? cover;

  @JsonKey(name: 'partInUsers')
  final List<PartUsersResponse>? users;
  final List<DiscussMessagesResponse>? discussMessages;

  DiscussNetworkResponse(
      this.id,
      this.title,
      this.description,
      this.discussMsgs,
      this.status,
      this.statusDictText,
      this.praiseCount,
      this.beginDate,
      this.endDate,
      this.createBy,
      this.createTime,
      this.updateBy,
      this.updateTime,
      this.cover,
      this.users,
      this.discussMessages);

  factory DiscussNetworkResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscussNetworkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussNetworkResponseToJson(this);
}

@JsonSerializable()
class DiscussMessagesResponse {
  final String id; // "1504641203290071042"
  final String? message; // "<p>测试留言</p>"
  final String? ownerName; // "符佳羽"
  final String? parentMsgId; // "0"
  final int? praiseCount; // 0
  final String? userId; // "1501143094266204161"
  final String? createBy;
  final String? createTime;
  final String? updateBy;
  final String? updateTime;

  DiscussMessagesResponse(
      this.id,
      this.message,
      this.ownerName,
      this.parentMsgId,
      this.praiseCount,
      this.userId,
      this.createBy,
      this.createTime,
      this.updateBy,
      this.updateTime);

  factory DiscussMessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscussMessagesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussMessagesResponseToJson(this);
}

@JsonSerializable()
class PartUsersResponse {
  final String? company;
  final String? createBy; //"admin"
  final String id; //"1497125780256534530"
  final String? idCard;
  final String? phone; //"18384777803"
  final String? post; //"总经理"
  final String? realname; //"程杰"
  final String? telephone; //"13322222222"
  final String? updateBy; //"admin"
  final String? username; //"chengjie"

  PartUsersResponse(
      this.company,
      this.createBy,
      this.id,
      this.idCard,
      this.phone,
      this.post,
      this.realname,
      this.telephone,
      this.updateBy,
      this.username);

  factory PartUsersResponse.fromJson(Map<String, dynamic> json) =>
      _$PartUsersResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PartUsersResponseToJson(this);
}
