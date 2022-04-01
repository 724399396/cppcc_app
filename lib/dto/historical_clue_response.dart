import 'package:json_annotation/json_annotation.dart';

part 'historical_clue_response.g.dart';

@JsonSerializable()
class HistoricalClueWrapper {
  final List<HistoricalClueResponse> records;
  late int total;
  late int size;
  late int current;
  late int pages;

  HistoricalClueWrapper(this.records);

  factory HistoricalClueWrapper.fromJson(Map<String, dynamic> json) =>
      _$HistoricalClueWrapperFromJson(json);
  Map<String, dynamic> toJson() => _$HistoricalClueWrapperToJson(this);
}

@JsonSerializable()
class HistoricalClueResponse {
  late String id;
  late String? content;
  late String? createBy;
  late String? createTime;
  late String? phone;
  late String? title;
  late String? provider;
  late String? sysOrgCode;
  late String? unit;
  late String? updateBy;
  late String? updateTime;

  HistoricalClueResponse();

  factory HistoricalClueResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoricalClueResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HistoricalClueResponseToJson(this);
}
