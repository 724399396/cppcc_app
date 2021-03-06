import 'package:json_annotation/json_annotation.dart';

part 'discuss_network_response.g.dart';

@JsonSerializable()
class DiscussNetworkResponse {
  final String id;
  final String title;
  final String? description;
  late String? discussMsgs;
  final int? status;
  @JsonKey(name: 'status_dictText')
  final String? statusDictText;
  final String? beginDate;
  final String? endDate;
  final String createBy;
  final String createTime;
  final String? updateBy;
  final String? updateTime;
  final String? cover;
  final bool? read;
  final int? thumbUpCount;
  final bool? thumbUpStatus;
  final int? commentCount;

  @JsonKey(name: 'partInUsers')
  final List<PartUsersResponse>? users;
  final List<DiscussMessagesResponse>? discussMessages;
  final List<DicusssFileResponse>? discussFiles;

  DiscussNetworkResponse(
      this.id,
      this.title,
      this.description,
      this.discussMsgs,
      this.status,
      this.statusDictText,
      this.beginDate,
      this.endDate,
      this.createBy,
      this.createTime,
      this.updateBy,
      this.updateTime,
      this.cover,
      this.users,
      this.discussMessages,
      this.read,
      this.thumbUpCount,
      this.thumbUpStatus,
      this.commentCount,
      this.discussFiles);

  factory DiscussNetworkResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscussNetworkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussNetworkResponseToJson(this);

  static List<DiscussNetworkResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => DiscussNetworkResponse.fromJson(e)).toList();
}

@JsonSerializable()
class DiscussMessagesResponse {
  final String id;
  final String? message;
  final String? ownerName;
  final String? ownerAvatar;
  final String? parentMsgId;
  final String? userId;
  final String? createBy;
  final String? createTime;
  final String? updateBy;
  final String? updateTime;
  final int? thumbUpCount;
  final bool? thumbUpStatus;

  DiscussMessagesResponse(
    this.id,
    this.message,
    this.ownerName,
    this.ownerAvatar,
    this.parentMsgId,
    this.userId,
    this.createBy,
    this.createTime,
    this.updateBy,
    this.updateTime,
    this.thumbUpCount,
    this.thumbUpStatus,
  );

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
  final String? post; //"?????????"
  final String? realname; //"??????"
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

@JsonSerializable()
class DicusssFileResponse {
  final String id;
  final String title;
  final String content;
  final String? createTime;
  @JsonKey(name: 'author_dictText')
  final String? authorRealname;

  DicusssFileResponse(
      this.id, this.title, this.content, this.createTime, this.authorRealname);

  factory DicusssFileResponse.fromJson(Map<String, dynamic> json) =>
      _$DicusssFileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DicusssFileResponseToJson(this);
}
