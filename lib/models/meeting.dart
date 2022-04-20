import 'package:equatable/equatable.dart';

class MeetingActiveRecord extends Equatable {
  final String userIdDictText;
  const MeetingActiveRecord({
    required this.userIdDictText,
  });

  MeetingActiveRecord copyWith({
    String? userIdDictText,
  }) {
    return MeetingActiveRecord(
      userIdDictText: userIdDictText ?? this.userIdDictText,
    );
  }

  @override
  String toString() => 'MeetingActiveRecord(userIdDictText: $userIdDictText)';

  @override
  List<Object> get props => [userIdDictText];
}

class Broadcast extends Equatable {
  final String title; //"大众创业，万众创新"
  final String content; //"<p>大众创业，万众创新</p>"
  final String createTime; //"2022-03-21 11:49:15"
  const Broadcast({
    required this.title,
    required this.content,
    required this.createTime,
  });

  Broadcast copyWith({
    String? title,
    String? content,
    String? createTime,
  }) {
    return Broadcast(
      title: title ?? this.title,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
    );
  }

  @override
  String toString() =>
      'Broadcast(title: $title, content: $content, createTime: $createTime)';

  @override
  List<Object> get props => [title, content, createTime];
}

class Meeting extends Equatable {
  final String id;
  final String title;
  final String address;
  final String beginDate;
  final String startTime;
  final String endTime;
  final String content;
  final int status;
  final String statusDictText;
  final bool? read;
  const Meeting({
    required this.id,
    required this.title,
    required this.address,
    required this.beginDate,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.status,
    required this.statusDictText,
    required this.read,
  });

  Meeting copyWith({
    String? id,
    String? title,
    String? address,
    String? beginDate,
    String? startTime,
    String? endTime,
    String? content,
    int? status,
    String? statusDictText,
    bool? read,
  }) {
    return Meeting(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      beginDate: beginDate ?? this.beginDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      content: content ?? this.content,
      status: status ?? this.status,
      statusDictText: statusDictText ?? this.statusDictText,
      read: read ?? this.read,
    );
  }

  @override
  String toString() {
    return 'Meeting(id: $id, title: $title, address: $address, beginDate: $beginDate, startTime: $startTime, endTime: $endTime, content: $content, status: $status, statusDictText: $statusDictText, read: $read)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      address,
      beginDate,
      startTime,
      endTime,
      content,
      status,
      statusDictText,
      read ?? '',
    ];
  }
}

class MeetingDetail extends Equatable {
  final String id;
  final String title;
  final String address;
  final String beginDate;
  final String startTime;
  final String endTime;
  final String content;
  final int status;
  final String statusDictText;
  final int type;
  final String typeDicttext;
  final String createBy;
  final String signQrcode;
  final List<MeetingActiveRecord> userRecords;
  final List<Broadcast> broadcasts;
  const MeetingDetail({
    required this.id,
    required this.title,
    required this.address,
    required this.beginDate,
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.status,
    required this.statusDictText,
    required this.type,
    required this.typeDicttext,
    required this.createBy,
    required this.signQrcode,
    required this.userRecords,
    required this.broadcasts,
  });

  MeetingDetail copyWith({
    String? id,
    String? title,
    String? address,
    String? beginDate,
    String? startTime,
    String? endTime,
    String? content,
    int? status,
    String? statusDictText,
    int? type,
    String? typeDicttext,
    String? createBy,
    String? signQrcode,
    List<MeetingActiveRecord>? userRecords,
    List<Broadcast>? broadcasts,
  }) {
    return MeetingDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      address: address ?? this.address,
      beginDate: beginDate ?? this.beginDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      content: content ?? this.content,
      status: status ?? this.status,
      statusDictText: statusDictText ?? this.statusDictText,
      type: type ?? this.type,
      typeDicttext: typeDicttext ?? this.typeDicttext,
      createBy: createBy ?? this.createBy,
      signQrcode: signQrcode ?? this.signQrcode,
      userRecords: userRecords ?? this.userRecords,
      broadcasts: broadcasts ?? this.broadcasts,
    );
  }

  @override
  String toString() {
    return 'MeetingDetail(id: $id, title: $title, address: $address, beginDate: $beginDate, startTime: $startTime, endTime: $endTime, content: $content, status: $status, statusDictText: $statusDictText, type: $type, typeDicttext: $typeDicttext, createBy: $createBy, signQrcode: $signQrcode, userRecords: $userRecords, broadcasts: $broadcasts)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      address,
      beginDate,
      startTime,
      endTime,
      content,
      status,
      statusDictText,
      type,
      typeDicttext,
      createBy,
      signQrcode,
      userRecords,
      broadcasts,
    ];
  }
}
