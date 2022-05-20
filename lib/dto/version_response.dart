import 'package:json_annotation/json_annotation.dart';

part 'version_response.g.dart';

@JsonSerializable()
class VersionResponse {
  final String version;
  final String apkUrl;

  VersionResponse(this.version, this.apkUrl);

  factory VersionResponse.fromJson(Map<String, dynamic> json) =>
      _$VersionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VersionResponseToJson(this);
}
