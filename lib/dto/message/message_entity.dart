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

	late dynamic busId;
	late String readFlag;
	late String anntId;
	late dynamic pageSize;
	late String msgAbstract;
	late String priority;
	late String userId;
	late String sendTime;
	late dynamic openType;
	late dynamic openPage;
	late String titile;
	late String msgContent;
	late String sender;
	late dynamic bizSource;
	late dynamic pageNo;
	late String id;
	late String msgCategory;
	late dynamic busType;
  
  MessageRecords();

  factory MessageRecords.fromJson(Map<String, dynamic> json) => $MessageRecordsFromJson(json);

  Map<String, dynamic> toJson() => $MessageRecordsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}