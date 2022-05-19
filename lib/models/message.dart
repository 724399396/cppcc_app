import 'package:equatable/equatable.dart';

import 'package:cppcc_app/dto/message_type.dart';

class Message extends Equatable {
  final String id;
  final String title;
  final String msgContent;
  final String sendTime;
  final bool read;
  final MessageType type;
  final String? sendUserId;
  const Message({
    required this.id,
    required this.title,
    required this.msgContent,
    required this.sendTime,
    required this.read,
    required this.type,
    required this.sendUserId,
  });

  Message copyWith({
    String? id,
    String? title,
    String? msgContent,
    String? sendTime,
    bool? read,
    MessageType? type,
    String? sendUserId,
  }) {
    return Message(
      id: id ?? this.id,
      title: title ?? this.title,
      msgContent: msgContent ?? this.msgContent,
      sendTime: sendTime ?? this.sendTime,
      read: read ?? this.read,
      type: type ?? this.type,
      sendUserId: sendUserId ?? this.sendUserId,
    );
  }

  @override
  String toString() {
    return 'Message(id: $id, title: $title, msgContent: $msgContent, sendTime: $sendTime, read: $read, type: $type, sendUserId: $sendUserId)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      msgContent,
      sendTime,
      read,
      type,
      sendUserId ?? '',
    ];
  }
}
