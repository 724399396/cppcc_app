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
  late dynamic appendix;
  late dynamic categoryDictText;
  late String? author;
  @JsonKey(name: "type_dictText")
  late String? typeDicttext;
  late String? updateTime;
  late int? type;
  late String? title;
  late String? content;
  late String? cover;
  late int? hits;
  late String? createBy;
  late String? createTime;
  late String? updateBy;
  late String id;
  late int? category;

  MeetingResponse();

  factory MeetingResponse.fromJson(Map<String, dynamic> json) =>
      _$MeetingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MeetingResponseToJson(this);
}
