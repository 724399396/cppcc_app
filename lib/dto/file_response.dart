import 'package:json_annotation/json_annotation.dart';

part 'file_response.g.dart';

@JsonSerializable()
class FileResponse {
  final String url;
  FileResponse(this.url);

  factory FileResponse.fromJson(Map<String, dynamic> json) =>
      _$FileResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FileResponseToJson(this);
}
