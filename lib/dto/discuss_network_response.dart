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
  final String? partInUsers;
  final int? praiseCount;
  // ignore: unnecessary_question_mark
  final dynamic? discussFiles;
  final String? beginDate;
  final String? endDate;
  final String createBy;
  final String createTime;
  final String? updateBy;
  final String? updateTime;

  final String? cover;

  DiscussNetworkResponse(
      this.id,
      this.title,
      this.description,
      this.discussMsgs,
      this.status,
      this.statusDictText,
      this.partInUsers,
      this.praiseCount,
      this.discussFiles,
      this.beginDate,
      this.endDate,
      this.createBy,
      this.createTime,
      this.updateBy,
      this.updateTime,
      this.cover);

  factory DiscussNetworkResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscussNetworkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussNetworkResponseToJson(this);
}
