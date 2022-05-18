import 'package:json_annotation/json_annotation.dart';

part 'discuss_network_change_response.g.dart';

@JsonSerializable()
class DiscussNetworkChangeResponse {
  final int type;
  final String? userRealname;
  final int? thumbUpCount;
  final String? thumbUpUserId;
  final String? sourceId;
  final Map<String, dynamic>? data;

  DiscussNetworkChangeResponse(this.type, this.userRealname, this.thumbUpCount,
      this.thumbUpUserId, this.sourceId, this.data);

  factory DiscussNetworkChangeResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscussNetworkChangeResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DiscussNetworkChangeResponseToJson(this);
}
