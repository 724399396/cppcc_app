import 'package:cppcc_app/generated/json/base/json_convert_content.dart';
import 'package:cppcc_app/dto/news/news_topic_entity.dart';

NewsTopicEntity $NewsTopicEntityFromJson(Map<String, dynamic> json) {
	final NewsTopicEntity newsTopicEntity = NewsTopicEntity();
	final List<NewsTopicRecords>? records = jsonConvert.convertListNotNull<NewsTopicRecords>(json['records']);
	if (records != null) {
		newsTopicEntity.records = records;
	}
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		newsTopicEntity.total = total;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		newsTopicEntity.size = size;
	}
	final int? current = jsonConvert.convert<int>(json['current']);
	if (current != null) {
		newsTopicEntity.current = current;
	}
	final List<dynamic>? orders = jsonConvert.convertListNotNull<dynamic>(json['orders']);
	if (orders != null) {
		newsTopicEntity.orders = orders;
	}
	final bool? optimizeCountSql = jsonConvert.convert<bool>(json['optimizeCountSql']);
	if (optimizeCountSql != null) {
		newsTopicEntity.optimizeCountSql = optimizeCountSql;
	}
	final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
	if (searchCount != null) {
		newsTopicEntity.searchCount = searchCount;
	}
	final dynamic? countId = jsonConvert.convert<dynamic>(json['countId']);
	if (countId != null) {
		newsTopicEntity.countId = countId;
	}
	final dynamic? maxLimit = jsonConvert.convert<dynamic>(json['maxLimit']);
	if (maxLimit != null) {
		newsTopicEntity.maxLimit = maxLimit;
	}
	final int? pages = jsonConvert.convert<int>(json['pages']);
	if (pages != null) {
		newsTopicEntity.pages = pages;
	}
	return newsTopicEntity;
}

Map<String, dynamic> $NewsTopicEntityToJson(NewsTopicEntity entity) {
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

NewsTopicRecords $NewsTopicRecordsFromJson(Map<String, dynamic> json) {
	final NewsTopicRecords newsTopicRecords = NewsTopicRecords();
	final String? createBy = jsonConvert.convert<String>(json['createBy']);
	if (createBy != null) {
		newsTopicRecords.createBy = createBy;
	}
	final String? createTime = jsonConvert.convert<String>(json['createTime']);
	if (createTime != null) {
		newsTopicRecords.createTime = createTime;
	}
	final String? updateBy = jsonConvert.convert<String>(json['updateBy']);
	if (updateBy != null) {
		newsTopicRecords.updateBy = updateBy;
	}
	final String? itemValue = jsonConvert.convert<String>(json['itemValue']);
	if (itemValue != null) {
		newsTopicRecords.itemValue = itemValue;
	}
	final int? sortOrder = jsonConvert.convert<int>(json['sortOrder']);
	if (sortOrder != null) {
		newsTopicRecords.sortOrder = sortOrder;
	}
	final String? description = jsonConvert.convert<String>(json['description']);
	if (description != null) {
		newsTopicRecords.description = description;
	}
	final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
	if (updateTime != null) {
		newsTopicRecords.updateTime = updateTime;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		newsTopicRecords.id = id;
	}
	final String? dictId = jsonConvert.convert<String>(json['dictId']);
	if (dictId != null) {
		newsTopicRecords.dictId = dictId;
	}
	final String? statusDicttext = jsonConvert.convert<String>(json['status_dictText']);
	if (statusDicttext != null) {
		newsTopicRecords.statusDicttext = statusDicttext;
	}
	final String? itemText = jsonConvert.convert<String>(json['itemText']);
	if (itemText != null) {
		newsTopicRecords.itemText = itemText;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		newsTopicRecords.status = status;
	}
	return newsTopicRecords;
}

Map<String, dynamic> $NewsTopicRecordsToJson(NewsTopicRecords entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['createBy'] = entity.createBy;
	data['createTime'] = entity.createTime;
	data['updateBy'] = entity.updateBy;
	data['itemValue'] = entity.itemValue;
	data['sortOrder'] = entity.sortOrder;
	data['description'] = entity.description;
	data['updateTime'] = entity.updateTime;
	data['id'] = entity.id;
	data['dictId'] = entity.dictId;
	data['status_dictText'] = entity.statusDicttext;
	data['itemText'] = entity.itemText;
	data['status'] = entity.status;
	return data;
}