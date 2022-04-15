import 'package:equatable/equatable.dart';

class Mail extends Equatable {
  final String id;
  final String title;
  final String content;
  final String phone;
  final int category;
  final String userId;
  final String userIdDictText;
  final int type;
  final String typeDictText;
  final String createBy;
  final String createTime;
  final bool read;
  const Mail({
    required this.id,
    required this.title,
    required this.content,
    required this.phone,
    required this.category,
    required this.userId,
    required this.userIdDictText,
    required this.type,
    required this.typeDictText,
    required this.createBy,
    required this.createTime,
    required this.read,
  });

  Mail copyWith({
    String? id,
    String? title,
    String? content,
    String? phone,
    int? category,
    String? userId,
    String? userIdDictText,
    int? type,
    String? typeDictText,
    String? createBy,
    String? createTime,
    bool? read,
  }) {
    return Mail(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      phone: phone ?? this.phone,
      category: category ?? this.category,
      userId: userId ?? this.userId,
      userIdDictText: userIdDictText ?? this.userIdDictText,
      type: type ?? this.type,
      typeDictText: typeDictText ?? this.typeDictText,
      createBy: createBy ?? this.createBy,
      createTime: createTime ?? this.createTime,
      read: read ?? this.read,
    );
  }

  @override
  String toString() {
    return 'Mail(id: $id, title: $title, content: $content, phone: $phone, category: $category, userId: $userId, userIdDictText: $userIdDictText, type: $type, typeDictText: $typeDictText, createBy: $createBy, createTime: $createTime, read: $read)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      content,
      phone,
      category,
      userId,
      userIdDictText,
      type,
      typeDictText,
      createBy,
      createTime,
      read,
    ];
  }
}
