import 'package:equatable/equatable.dart';

class PartUser extends Equatable {
  final String userRealname;
  const PartUser({
    this.userRealname = '',
  });

  PartUser copyWith({
    String? userRealname,
  }) {
    return PartUser(
      userRealname: userRealname ?? this.userRealname,
    );
  }

  @override
  String toString() => 'PartUser(userRealname: $userRealname)';

  @override
  List<Object> get props => [userRealname];
}

class DiscussMessage extends Equatable {
  final String id;
  final String message;
  final String ownerName;
  final String? ownerAvatar;
  final int praiseCount;
  final String createTime;

  const DiscussMessage({
    required this.id,
    required this.message,
    required this.ownerName,
    required this.ownerAvatar,
    required this.praiseCount,
    required this.createTime,
  });

  DiscussMessage copyWith({
    String? id,
    String? message,
    String? ownerName,
    String? ownerAvatar,
    int? praiseCount,
    String? createTime,
  }) {
    return DiscussMessage(
      id: id ?? this.id,
      message: message ?? this.message,
      ownerName: ownerName ?? this.ownerName,
      ownerAvatar: ownerAvatar ?? this.ownerAvatar,
      praiseCount: praiseCount ?? this.praiseCount,
      createTime: createTime ?? this.createTime,
    );
  }

  @override
  String toString() {
    return 'DiscussMessage(id: $id, message: $message, ownerName: $ownerName, ownerAvatar: $ownerAvatar, praiseCount: $praiseCount, createTime: $createTime)';
  }

  @override
  List<Object> get props {
    return [
      id,
      message,
      ownerName,
      ownerAvatar ?? '',
      praiseCount,
      createTime,
    ];
  }
}

class DiscussFile extends Equatable {
  final String id;
  final String title;
  final String content;
  final DateTime createTime;
  final String authorRealname;
  const DiscussFile({
    required this.id,
    required this.title,
    required this.content,
    required this.createTime,
    required this.authorRealname,
  });

  DiscussFile copyWith({
    String? id,
    String? title,
    String? content,
    DateTime? createTime,
    String? authorRealname,
  }) {
    return DiscussFile(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      authorRealname: authorRealname ?? this.authorRealname,
    );
  }

  @override
  String toString() {
    return 'DiscussFile(id: $id, title: $title, content: $content, createTime: $createTime, authorRealname: $authorRealname)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      content,
      createTime,
      authorRealname,
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
  final List<DiscussFile> discussFiles;
  final bool read;
  final int thumbUpCount;
  final bool thumbUpStatus;
  final int commentCount;
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
    required this.discussFiles,
    required this.read,
    required this.thumbUpCount,
    required this.thumbUpStatus,
    required this.commentCount,
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
    List<DiscussFile>? discussFiles,
    bool? read,
    int? thumbUpCount,
    bool? thumbUpStatus,
    int? commentCount,
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
      discussFiles: discussFiles ?? this.discussFiles,
      read: read ?? this.read,
      thumbUpCount: thumbUpCount ?? this.thumbUpCount,
      thumbUpStatus: thumbUpStatus ?? this.thumbUpStatus,
      commentCount: commentCount ?? this.commentCount,
    );
  }

  @override
  String toString() {
    return 'DiscussNetwork(id: $id, title: $title, description: $description, discussMsgs: $discussMsgs, status: $status, statusDictText: $statusDictText, praiseCount: $praiseCount, beginDate: $beginDate, endDate: $endDate, createBy: $createBy, createTime: $createTime, updateBy: $updateBy, updateTime: $updateTime, cover: $cover, userRecords: $userRecords, discussMessages: $discussMessages, discussFiles: $discussFiles, read: $read, thumbUpCount: $thumbUpCount, thumbUpStatus: $thumbUpStatus, commentCount: $commentCount)';
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
      discussFiles,
      read,
      thumbUpCount,
      thumbUpStatus,
      commentCount,
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
