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
  final int type;
  final String typeDicttext;
  final String createBy;
  final String? signQrcode;
  final List<MeetingActiveRecord> userRecords;

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
    required this.type,
    required this.typeDicttext,
    required this.createBy,
    required this.signQrcode,
    this.userRecords = const [],
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
    int? type,
    String? typeDicttext,
    String? createBy,
    String? signQrcode,
    List<MeetingActiveRecord>? userRecords,
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
      type: type ?? this.type,
      typeDicttext: typeDicttext ?? this.typeDicttext,
      createBy: createBy ?? this.createBy,
      signQrcode: signQrcode ?? this.signQrcode,
      userRecords: userRecords ?? this.userRecords,
    );
  }

  @override
  String toString() {
    return 'Meeting(id: $id, title: $title, address: $address, beginDate: $beginDate, startTime: $startTime, endTime: $endTime, content: $content, status: $status, statusDictText: $statusDictText, type: $type, typeDicttext: $typeDicttext, createBy: $createBy, signQrcode: $signQrcode, userRecords: $userRecords)';
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
      userRecords,
    ];
  }
}
