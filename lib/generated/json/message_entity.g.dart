import 'package:cppcc_app/generated/json/base/json_convert_content.dart';
import 'package:cppcc_app/dto/message/message_entity.dart';

MessageEntity $MessageEntityFromJson(Map<String, dynamic> json) {
	final MessageEntity messageEntity = MessageEntity();
	final List<MessageRecords>? records = jsonConvert.convertListNotNull<MessageRecords>(json['records']);
	if (records != null) {
		messageEntity.records = records;
	}
	final int? total = jsonConvert.convert<int>(json['total']);
	if (total != null) {
		messageEntity.total = total;
	}
	final int? size = jsonConvert.convert<int>(json['size']);
	if (size != null) {
		messageEntity.size = size;
	}
	final int? current = jsonConvert.convert<int>(json['current']);
	if (current != null) {
		messageEntity.current = current;
	}
	final List<dynamic>? orders = jsonConvert.convertListNotNull<dynamic>(json['orders']);
	if (orders != null) {
		messageEntity.orders = orders;
	}
	final bool? optimizeCountSql = jsonConvert.convert<bool>(json['optimizeCountSql']);
	if (optimizeCountSql != null) {
		messageEntity.optimizeCountSql = optimizeCountSql;
	}
	final bool? searchCount = jsonConvert.convert<bool>(json['searchCount']);
	if (searchCount != null) {
		messageEntity.searchCount = searchCount;
	}
	final dynamic? countId = jsonConvert.convert<dynamic>(json['countId']);
	if (countId != null) {
		messageEntity.countId = countId;
	}
	final dynamic? maxLimit = jsonConvert.convert<dynamic>(json['maxLimit']);
	if (maxLimit != null) {
		messageEntity.maxLimit = maxLimit;
	}
	final int? pages = jsonConvert.convert<int>(json['pages']);
	if (pages != null) {
		messageEntity.pages = pages;
	}
	return messageEntity;
}

Map<String, dynamic> $MessageEntityToJson(MessageEntity entity) {
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

MessageRecords $MessageRecordsFromJson(Map<String, dynamic> json) {
	final MessageRecords messageRecords = MessageRecords();
	final dynamic? busId = jsonConvert.convert<dynamic>(json['busId']);
	if (busId != null) {
		messageRecords.busId = busId;
	}
	final String? readFlag = jsonConvert.convert<String>(json['readFlag']);
	if (readFlag != null) {
		messageRecords.readFlag = readFlag;
	}
	final String? anntId = jsonConvert.convert<String>(json['anntId']);
	if (anntId != null) {
		messageRecords.anntId = anntId;
	}
	final dynamic? pageSize = jsonConvert.convert<dynamic>(json['pageSize']);
	if (pageSize != null) {
		messageRecords.pageSize = pageSize;
	}
	final String? msgAbstract = jsonConvert.convert<String>(json['msgAbstract']);
	if (msgAbstract != null) {
		messageRecords.msgAbstract = msgAbstract;
	}
	final String? priority = jsonConvert.convert<String>(json['priority']);
	if (priority != null) {
		messageRecords.priority = priority;
	}
	final String? userId = jsonConvert.convert<String>(json['userId']);
	if (userId != null) {
		messageRecords.userId = userId;
	}
	final String? sendTime = jsonConvert.convert<String>(json['sendTime']);
	if (sendTime != null) {
		messageRecords.sendTime = sendTime;
	}
	final dynamic? openType = jsonConvert.convert<dynamic>(json['openType']);
	if (openType != null) {
		messageRecords.openType = openType;
	}
	final dynamic? openPage = jsonConvert.convert<dynamic>(json['openPage']);
	if (openPage != null) {
		messageRecords.openPage = openPage;
	}
	final String? titile = jsonConvert.convert<String>(json['titile']);
	if (titile != null) {
		messageRecords.titile = titile;
	}
	final String? msgContent = jsonConvert.convert<String>(json['msgContent']);
	if (msgContent != null) {
		messageRecords.msgContent = msgContent;
	}
	final String? sender = jsonConvert.convert<String>(json['sender']);
	if (sender != null) {
		messageRecords.sender = sender;
	}
	final dynamic? bizSource = jsonConvert.convert<dynamic>(json['bizSource']);
	if (bizSource != null) {
		messageRecords.bizSource = bizSource;
	}
	final dynamic? pageNo = jsonConvert.convert<dynamic>(json['pageNo']);
	if (pageNo != null) {
		messageRecords.pageNo = pageNo;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		messageRecords.id = id;
	}
	final String? msgCategory = jsonConvert.convert<String>(json['msgCategory']);
	if (msgCategory != null) {
		messageRecords.msgCategory = msgCategory;
	}
	final dynamic? busType = jsonConvert.convert<dynamic>(json['busType']);
	if (busType != null) {
		messageRecords.busType = busType;
	}
	return messageRecords;
}

Map<String, dynamic> $MessageRecordsToJson(MessageRecords entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['busId'] = entity.busId;
	data['readFlag'] = entity.readFlag;
	data['anntId'] = entity.anntId;
	data['pageSize'] = entity.pageSize;
	data['msgAbstract'] = entity.msgAbstract;
	data['priority'] = entity.priority;
	data['userId'] = entity.userId;
	data['sendTime'] = entity.sendTime;
	data['openType'] = entity.openType;
	data['openPage'] = entity.openPage;
	data['titile'] = entity.titile;
	data['msgContent'] = entity.msgContent;
	data['sender'] = entity.sender;
	data['bizSource'] = entity.bizSource;
	data['pageNo'] = entity.pageNo;
	data['id'] = entity.id;
	data['msgCategory'] = entity.msgCategory;
	data['busType'] = entity.busType;
	return data;
}