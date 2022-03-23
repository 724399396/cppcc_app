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
  late String? broadcasts;
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

  MeetingResponse();

  factory MeetingResponse.fromJson(Map<String, dynamic> json) =>
      _$MeetingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingResponseToJson(this);
}
