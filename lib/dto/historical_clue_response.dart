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
  final String id;
  final String? content;
  final String? createBy;
  final String? createTime;
  final String? phone;
  final String? title;
  final String? provider;
  final String? sysOrgCode;
  final String? unit;
  final String? updateBy;
  final String? updateTime;
  final bool? read;

  HistoricalClueResponse(
      this.id,
      this.content,
      this.createBy,
      this.createTime,
      this.phone,
      this.title,
      this.provider,
      this.sysOrgCode,
      this.unit,
      this.updateBy,
      this.updateTime,
      this.read);

  factory HistoricalClueResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoricalClueResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HistoricalClueResponseToJson(this);
}
