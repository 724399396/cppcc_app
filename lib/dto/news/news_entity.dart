import 'dart:convert';
import 'package:cppcc_app/generated/json/base/json_field.dart';
import 'package:cppcc_app/generated/json/news_entity.g.dart';

@JsonSerializable()
class NewsEntity {

	late List<NewsRecords> records;
	late int total;
	late int size;
	late int current;
	late List<dynamic> orders;
	late bool optimizeCountSql;
	late bool searchCount;
	late dynamic countId;
	late dynamic maxLimit;
	late int pages;
  
  NewsEntity();

  factory NewsEntity.fromJson(Map<String, dynamic> json) => $NewsEntityFromJson(json);

  Map<String, dynamic> toJson() => $NewsEntityToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}

@JsonSerializable()
class NewsRecords {

	late dynamic appendix;
	late String author;
	@JSONField(name: "type_dictText")
	late String typeDicttext;
	late String updateTime;
	late int type;
	late String title;
	late String content;
	late String cover;
	late int hits;
	late String createBy;
	late String createTime;
	late String updateBy;
	@JSONField(name: "category_dictText")
	late String categoryDicttext;
	late String id;
	late int category;
  
  NewsRecords();

  factory NewsRecords.fromJson(Map<String, dynamic> json) => $NewsRecordsFromJson(json);

  Map<String, dynamic> toJson() => $NewsRecordsToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}