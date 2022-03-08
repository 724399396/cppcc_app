import 'dart:convert';
import 'package:cppcc_app/generated/json/base/json_field.dart';
import 'package:cppcc_app/generated/json/news_topic_entity.g.dart';

@JsonSerializable()
class NewsTopicEntity {

	late List<NewsTopicRecords> records;
	late int total;
	late int size;
	late int current;
	late List<dynamic> orders;
	late bool optimizeCountSql;
	late bool searchCount;
	late dynamic countId;
	late dynamic maxLimit;
	late int pages;
  
  NewsTopicEntity();

  factory NewsTopicEntity.fromJson(Map<String, dynamic> json) => $NewsTopicEntityFromJson(json);

  Map<String, dynamic> toJson() => $NewsTopicEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class NewsTopicRecords {

	late String createBy;
	late String createTime;
	late String updateBy;
	late String itemValue;
	late int sortOrder;
	late String description;
	late String updateTime;
	late String id;
	late String dictId;
	@JSONField(name: "status_dictText")
	late String statusDicttext;
	late String itemText;
	late int status;
  
  NewsTopicRecords();

  factory NewsTopicRecords.fromJson(Map<String, dynamic> json) => $NewsTopicRecordsFromJson(json);

  Map<String, dynamic> toJson() => $NewsTopicRecordsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}