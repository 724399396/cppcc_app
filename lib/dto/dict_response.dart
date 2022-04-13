import 'package:json_annotation/json_annotation.dart';

part 'dict_response.g.dart';

@JsonSerializable()
class DictResponse {
  final String dictCode;
  final String itemValue;
  final String itemText;

  DictResponse(this.dictCode, this.itemValue, this.itemText);

  factory DictResponse.fromJson(Map<String, dynamic> json) =>
      _$DictResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DictResponseToJson(this);

  static List<DictResponse> fromJsonList(List<dynamic> json) =>
      json.map((e) => DictResponse.fromJson(e)).toList();
}
