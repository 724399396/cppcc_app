enum MessageType {
  notice,
  businessCard,
  system,
}

extension MessageTypeExtension on MessageType {
  String get description {
    switch (this) {
      case MessageType.notice:
        return '通知消息';
      case MessageType.businessCard:
        return '名片消息';
      case MessageType.system:
        return '系统消息';
      default:
        return '未知';
    }
  }

  int get code {
    switch (this) {
      case MessageType.notice:
        return 1;
      case MessageType.system:
        return 2;
      default:
        return -1;
    }
  }
}

MessageType convertToMessageTypeFromCode(String code) {
  for (var value in MessageType.values) {
    if (value.code.toString() == code) {
      return value;
    }
  }
  return MessageType.system;
}
