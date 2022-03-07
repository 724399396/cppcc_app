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
	final String? esReceiver = jsonConvert.convert<String>(json['esReceiver']);
	if (esReceiver != null) {
		messageRecords.esReceiver = esReceiver;
	}
	final String? essendstatusDicttext = jsonConvert.convert<String>(json['esSendStatus_dictText']);
	if (essendstatusDicttext != null) {
		messageRecords.essendstatusDicttext = essendstatusDicttext;
	}
	final String? estypeDicttext = jsonConvert.convert<String>(json['esType_dictText']);
	if (estypeDicttext != null) {
		messageRecords.estypeDicttext = estypeDicttext;
	}
	final String? esTitle = jsonConvert.convert<String>(json['esTitle']);
	if (esTitle != null) {
		messageRecords.esTitle = esTitle;
	}
	final String? updateTime = jsonConvert.convert<String>(json['updateTime']);
	if (updateTime != null) {
		messageRecords.updateTime = updateTime;
	}
	final String? remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		messageRecords.remark = remark;
	}
	final String? esSendStatus = jsonConvert.convert<String>(json['esSendStatus']);
	if (esSendStatus != null) {
		messageRecords.esSendStatus = esSendStatus;
	}
	final String? esSendTime = jsonConvert.convert<String>(json['esSendTime']);
	if (esSendTime != null) {
		messageRecords.esSendTime = esSendTime;
	}
	final String? createBy = jsonConvert.convert<String>(json['createBy']);
	if (createBy != null) {
		messageRecords.createBy = createBy;
	}
	final dynamic? esSendNum = jsonConvert.convert<dynamic>(json['esSendNum']);
	if (esSendNum != null) {
		messageRecords.esSendNum = esSendNum;
	}
	final String? createTime = jsonConvert.convert<String>(json['createTime']);
	if (createTime != null) {
		messageRecords.createTime = createTime;
	}
	final String? updateBy = jsonConvert.convert<String>(json['updateBy']);
	if (updateBy != null) {
		messageRecords.updateBy = updateBy;
	}
	final dynamic? esParam = jsonConvert.convert<dynamic>(json['esParam']);
	if (esParam != null) {
		messageRecords.esParam = esParam;
	}
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		messageRecords.id = id;
	}
	final String? esContent = jsonConvert.convert<String>(json['esContent']);
	if (esContent != null) {
		messageRecords.esContent = esContent;
	}
	final dynamic? esResult = jsonConvert.convert<dynamic>(json['esResult']);
	if (esResult != null) {
		messageRecords.esResult = esResult;
	}
	final String? esType = jsonConvert.convert<String>(json['esType']);
	if (esType != null) {
		messageRecords.esType = esType;
	}
	return messageRecords;
}

Map<String, dynamic> $MessageRecordsToJson(MessageRecords entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['esReceiver'] = entity.esReceiver;
	data['esSendStatus_dictText'] = entity.essendstatusDicttext;
	data['esType_dictText'] = entity.estypeDicttext;
	data['esTitle'] = entity.esTitle;
	data['updateTime'] = entity.updateTime;
	data['remark'] = entity.remark;
	data['esSendStatus'] = entity.esSendStatus;
	data['esSendTime'] = entity.esSendTime;
	data['createBy'] = entity.createBy;
	data['esSendNum'] = entity.esSendNum;
	data['createTime'] = entity.createTime;
	data['updateBy'] = entity.updateBy;
	data['esParam'] = entity.esParam;
	data['id'] = entity.id;
	data['esContent'] = entity.esContent;
	data['esResult'] = entity.esResult;
	data['esType'] = entity.esType;
	return data;
}