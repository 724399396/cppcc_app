import 'package:cppcc_app/generated/json/base/json_convert_content.dart';
import 'package:cppcc_app/dto/news/news_entity.dart';

NewsEntity $NewsEntityFromJson(Map<String, dynamic> json) {
	final NewsEntity newsEntity = NewsEntity();
	final List<NewsRecords>? records = jsonConvert.convertListNotNull<NewsRecords>(json['records']);
	if (records != null) {
		newsEntity.records = records;
	}
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		newsEntity.total = total;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		newsEntity.size = size;
	}
	final int? current = jsonConvert.convert<int>(json['current']);
	if (current != null) {
		newsEntity.current = current;
	}
	final List<dynamic>? orders = jsonConvert.convertListNotNull<dynamic>(json['orders']);
	if (orders != null) {
		newsEntity.orders = orders;
	}
	final bool? optimizeCountSql = jsonConvert.convert<bool>(json['optimizeCountSql']);
	if (optimizeCountSql != null) {
		newsEntity.optimizeCountSql = optimizeCountSql;
	}
	final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
	if (searchCount != null) {
		newsEntity.searchCount = searchCount;
	}
	final dynamic? countId = jsonConvert.convert<dynamic>(json['countId']);
	if (countId != null) {
		newsEntity.countId = countId;
	}
	final dynamic? maxLimit = jsonConvert.convert<dynamic>(json['maxLimit']);
	if (maxLimit != null) {
		newsEntity.maxLimit = maxLimit;
	}
	final int? pages = jsonConvert.convert<int>(json['pages']);
	if (pages != null) {
		newsEntity.pages = pages;
	}
	return newsEntity;
}

Map<String, dynamic> $NewsEntityToJson(NewsEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['records'] =  entity.records.map((v) => v.toJson()).toList();
	data['total'] = entity.total;
	data['size'] = entity.size;
	data['current'] = entity.current;
	data['orders'] =  entity.orders;
	data['optimizeCountSql'] = entity.optimizeCountSql;
	data['searchCount'] = entity.searchCount;
	data['countId'] = entity.countId;
	data['maxLimit'] = entity.maxLimit;
	data['pages'] = entity.pages;
	return data;
}

NewsRecords $NewsRecordsFromJson(Map<String, dynamic> json) {
	final NewsRecords newsRecords = NewsRecords();
	final dynamic? appendix = jsonConvert.convert<dynamic>(json['appendix']);
	if (appendix != null) {
		newsRecords.appendix = appendix;
	}
	final String? author = jsonConvert.convert<String>(json['author']);
	if (author != null) {
		newsRecords.author = author;
	}
	final String? typeDicttext = jsonConvert.convert<String>(json['type_dictText']);
	if (typeDicttext != null) {
		newsRecords.typeDicttext = typeDicttext;
	}
	final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
	if (updateTime != null) {
		newsRecords.updateTime = updateTime;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		newsRecords.type = type;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		newsRecords.title = title;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		newsRecords.content = content;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		newsRecords.cover = cover;
	}
	final int? hits = jsonConvert.convert<int>(json['hits']);
	if (hits != null) {
		newsRecords.hits = hits;
	}
	final String? createBy = jsonConvert.convert<String>(json['createBy']);
	if (createBy != null) {
		newsRecords.createBy = createBy;
	}
	final String? createTime = jsonConvert.convert<String>(json['createTime']);
	if (createTime != null) {
		newsRecords.createTime = createTime;
	}
	final String? updateBy = jsonConvert.convert<String>(json['updateBy']);
	if (updateBy != null) {
		newsRecords.updateBy = updateBy;
	}
	final String? categoryDicttext = jsonConvert.convert<String>(json['category_dictText']);
	if (categoryDicttext != null) {
		newsRecords.categoryDicttext = categoryDicttext;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		newsRecords.id = id;
	}
	final int? category = jsonConvert.convert<int>(json['category']);
	if (category != null) {
		newsRecords.category = category;
	}
	return newsRecords;
}

Map<String, dynamic> $NewsRecordsToJson(NewsRecords entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['appendix'] = entity.appendix;
	data['author'] = entity.author;
	data['type_dictText'] = entity.typeDicttext;
	data['updateTime'] = entity.updateTime;
	data['type'] = entity.type;
	data['title'] = entity.title;
	data['content'] = entity.content;
	data['cover'] = entity.cover;
	data['hits'] = entity.hits;
	data['createBy'] = entity.createBy;
	data['createTime'] = entity.createTime;
	data['updateBy'] = entity.updateBy;
	data['category_dictText'] = entity.categoryDicttext;
	data['id'] = entity.id;
	data['category'] = entity.category;
	return data;
}