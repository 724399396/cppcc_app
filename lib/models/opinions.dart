import 'package:equatable/equatable.dart';

class Opinion extends Equatable {
  final String id;
  final String title;
  final String typeDictText;
  final String author;
  final String content;
  final int status;
  final String statusDictText;
  final DateTime createTime;
  final bool read;

  const Opinion({
    required this.id,
    required this.title,
    required this.typeDictText,
    required this.author,
    required this.content,
    required this.status,
    required this.statusDictText,
    required this.createTime,
    required this.read,
  });

  Opinion copyWith({
    String? id,
    String? title,
    String? typeDictText,
    String? author,
    String? content,
    int? status,
    String? statusDictText,
    DateTime? createTime,
    bool? read,
  }) {
    return Opinion(
      id: id ?? this.id,
      title: title ?? this.title,
      typeDictText: typeDictText ?? this.typeDictText,
      author: author ?? this.author,
      content: content ?? this.content,
      status: status ?? this.status,
      statusDictText: statusDictText ?? this.statusDictText,
      createTime: createTime ?? this.createTime,
      read: read ?? this.read,
    );
  }

  @override
  String toString() {
    return 'Opinion(id: $id, title: $title, typeDictText: $typeDictText, author: $author, content: $content, status: $status, statusDictText: $statusDictText, createTime: $createTime, read: $read)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      typeDictText,
      author,
      content,
      status,
      statusDictText,
      createTime,
      read,
    ];
  }
}

enum OpinionListType {
  notFinished,
  finished,
}

extension OpinionListTypeExtension on OpinionListType {
  String get description {
    switch (this) {
      case OpinionListType.notFinished:
        return '社情民意提交';
      case OpinionListType.finished:
        return '社情民意办理';
    }
  }

  List<int> get refStatus {
    switch (this) {
      case OpinionListType.notFinished:
        return [1, 2, 3, 4, 5];
      case OpinionListType.finished:
        return [6];
    }
  }
}
