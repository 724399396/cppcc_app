import 'package:equatable/equatable.dart';

class PartUser extends Equatable {
  final String realname;
  const PartUser({
    this.realname = '',
  });

  PartUser copyWith({
    String? realname,
  }) {
    return PartUser(
      realname: realname ?? this.realname,
    );
  }

  @override
  String toString() => 'PartUser(realname: $realname)';

  @override
  List<Object> get props => [realname];
}

class DiscussMessage extends Equatable {
  final String message;
  final String ownerName;
  final String? ownerAvatar;
  final int praiseCount;
  final String createTime;

  const DiscussMessage({
    required this.message,
    required this.ownerName,
    required this.ownerAvatar,
    required this.praiseCount,
    required this.createTime,
  });

  DiscussMessage copyWith({
    String? message,
    String? ownerName,
    String? ownerAvatar,
    int? praiseCount,
    String? createTime,
  }) {
    return DiscussMessage(
      message: message ?? this.message,
      ownerName: ownerName ?? this.ownerName,
      ownerAvatar: ownerAvatar ?? this.ownerAvatar,
      praiseCount: praiseCount ?? this.praiseCount,
      createTime: createTime ?? this.createTime,
    );
  }

  @override
  String toString() {
    return 'DiscussMessage(message: $message, ownerName: $ownerName, ownerAvatar: $ownerAvatar, praiseCount: $praiseCount, createTime: $createTime)';
  }

  @override
  List<Object> get props {
    return [
      message,
      ownerName,
      ownerAvatar ?? '',
      praiseCount,
      createTime,
    ];
  }
}

class DiscussNetwork extends Equatable {
  final String id;
  final String title;
  final String description;
  final String discussMsgs;
  final int status;
  final String statusDictText;
  final int praiseCount;
  final String beginDate;
  final String endDate;
  final String createBy;
  final String createTime;
  final String updateBy;
  final String updateTime;
  final String? cover;
  final List<PartUser> userRecords;
  final List<DiscussMessage> discussMessages;
  final bool read;
  const DiscussNetwork({
    required this.id,
    required this.title,
    required this.description,
    required this.discussMsgs,
    required this.status,
    required this.statusDictText,
    required this.praiseCount,
    required this.beginDate,
    required this.endDate,
    required this.createBy,
    required this.createTime,
    required this.updateBy,
    required this.updateTime,
    required this.cover,
    required this.userRecords,
    required this.discussMessages,
    required this.read,
  });

  DiscussNetwork copyWith({
    String? id,
    String? title,
    String? description,
    String? discussMsgs,
    int? status,
    String? statusDictText,
    int? praiseCount,
    String? beginDate,
    String? endDate,
    String? createBy,
    String? createTime,
    String? updateBy,
    String? updateTime,
    String? cover,
    List<PartUser>? userRecords,
    List<DiscussMessage>? discussMessages,
    bool? read,
  }) {
    return DiscussNetwork(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      discussMsgs: discussMsgs ?? this.discussMsgs,
      status: status ?? this.status,
      statusDictText: statusDictText ?? this.statusDictText,
      praiseCount: praiseCount ?? this.praiseCount,
      beginDate: beginDate ?? this.beginDate,
      endDate: endDate ?? this.endDate,
      createBy: createBy ?? this.createBy,
      createTime: createTime ?? this.createTime,
      updateBy: updateBy ?? this.updateBy,
      updateTime: updateTime ?? this.updateTime,
      cover: cover ?? this.cover,
      userRecords: userRecords ?? this.userRecords,
      discussMessages: discussMessages ?? this.discussMessages,
      read: read ?? this.read,
    );
  }

  @override
  String toString() {
    return 'DiscussNetwork(id: $id, title: $title, description: $description, discussMsgs: $discussMsgs, status: $status, statusDictText: $statusDictText, praiseCount: $praiseCount, beginDate: $beginDate, endDate: $endDate, createBy: $createBy, createTime: $createTime, updateBy: $updateBy, updateTime: $updateTime, cover: $cover, userRecords: $userRecords, discussMessages: $discussMessages, read: $read)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      description,
      discussMsgs,
      status,
      statusDictText,
      praiseCount,
      beginDate,
      endDate,
      createBy,
      createTime,
      updateBy,
      updateTime,
      cover ?? '',
      userRecords,
      discussMessages,
      read,
    ];
  }
}

enum DiscussNetworkListType {
  notFinished,
  finished,
}

extension OpinionListTypeExtension on DiscussNetworkListType {
  String get description {
    switch (this) {
      case DiscussNetworkListType.notFinished:
        return '正在进行';
      case DiscussNetworkListType.finished:
        return '已结束';
    }
  }

  List<int> get refStatus {
    switch (this) {
      case DiscussNetworkListType.notFinished:
        return [1, 2];
      case DiscussNetworkListType.finished:
        return [3];
    }
  }
}
