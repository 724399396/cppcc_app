import 'dart:convert';
import 'package:cppcc_app/generated/json/base/json_field.dart';
import 'package:cppcc_app/generated/json/message_entity.g.dart';

@JsonSerializable()
class MessageEntity {

	late List<MessageRecords> records;
	late int total;
	late int size;
	late int current;
	late List<dynamic> orders;
	late bool optimizeCountSql;
	late bool searchCount;
	late dynamic countId;
	late dynamic maxLimit;
	late int pages;
  
  MessageEntity();

  factory MessageEntity.fromJson(Map<String, dynamic> json) => $MessageEntityFromJson(json);

  Map<String, dynamic> toJson() => $MessageEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class MessageRecords {

	late String esReceiver;
	@JSONField(name: "esSendStatus_dictText")
	late String essendstatusDicttext;
	@JSONField(name: "esType_dictText")
	late String estypeDicttext;
	late String esTitle;
	late String updateTime;
	late String remark;
	late String esSendStatus;
	late String esSendTime;
	late String createBy;
	late dynamic esSendNum;
	late String createTime;
	late String updateBy;
	late dynamic esParam;
	late String id;
	late String esContent;
	late dynamic esResult;
	late String esType;
  
  MessageRecords();

  factory MessageRecords.fromJson(Map<String, dynamic> json) => $MessageRecordsFromJson(json);

  Map<String, dynamic> toJson() => $MessageRecordsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}