import 'package:json_annotation/json_annotation.dart';

part 'two_meetings_response.g.dart';

@JsonSerializable()
class TwoMeetingsWrapper {
  final List<TwoMeetingsResponse> records;
  late int total;
  late int size;
  late int current;
  late int pages;

  TwoMeetingsWrapper(this.records);

  factory TwoMeetingsWrapper.fromJson(Map<String, dynamic> json) =>
      _$TwoMeetingsWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$TwoMeetingsWrapperToJson(this);
}

@JsonSerializable()
class TwoMeetingsResponse {
  final String id;
  final String title;
  final String? cover;
  final String content;
  final String? createAt;
  final int? hits;

  TwoMeetingsResponse(
      this.id, this.title, this.cover, this.content, this.createAt, this.hits);

  factory TwoMeetingsResponse.fromJson(Map<String, dynamic> json) =>
      _$TwoMeetingsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TwoMeetingsResponseToJson(this);
}
