import 'package:equatable/equatable.dart';

class Opinion extends Equatable {
  final String id;
  final String title;
  final String typeDictText;
  final String authorId;
  final String author;
  final String content;
  final int status;
  final String statusDictText;
  final DateTime createTime;
  final bool read;
  final String createBy;
  final List<OpinionProgress> progress;

  const Opinion({
    required this.id,
    required this.title,
    required this.typeDictText,
    required this.authorId,
    required this.author,
    required this.content,
    required this.status,
    required this.statusDictText,
    required this.createTime,
    required this.read,
    required this.createBy,
    this.progress = const [],
  });

  Opinion copyWith({
    String? id,
    String? title,
    String? typeDictText,
    String? authorId,
    String? author,
    String? content,
    int? status,
    String? statusDictText,
    DateTime? createTime,
    bool? read,
    String? createBy,
    List<OpinionProgress>? progress,
  }) {
    return Opinion(
      id: id ?? this.id,
      title: title ?? this.title,
      typeDictText: typeDictText ?? this.typeDictText,
      authorId: authorId ?? this.authorId,
      author: author ?? this.author,
      content: content ?? this.content,
      status: status ?? this.status,
      statusDictText: statusDictText ?? this.statusDictText,
      createTime: createTime ?? this.createTime,
      read: read ?? this.read,
      createBy: createBy ?? this.createBy,
      progress: progress ?? this.progress,
    );
  }

  @override
  String toString() {
    return 'Opinion(id: $id, title: $title, typeDictText: $typeDictText, authorId: $authorId, author: $author, content: $content, status: $status, statusDictText: $statusDictText, createTime: $createTime, read: $read, createBy: $createBy, progress: $progress)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      typeDictText,
      authorId,
      author,
      content,
      status,
      statusDictText,
      createTime,
      read,
      createBy,
      progress,
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

class KeyValue extends Equatable {
  final String key;
  final String value;
  const KeyValue({
    required this.key,
    required this.value,
  });

  KeyValue copyWith({
    String? key,
    String? value,
  }) {
    return KeyValue(
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }

  @override
  String toString() => 'KeyValue(key: $key, value: $value)';

  @override
  List<Object> get props => [key, value];
}

class OpinionProgress extends Equatable {
  final int type;
  final String typeDictText;
  final List<KeyValue> content;
  const OpinionProgress({
    required this.typeDictText,
    required this.content,
    required this.type,
  });

  OpinionProgress copyWith({
    int? type,
    String? typeDictText,
    List<KeyValue>? content,
  }) {
    return OpinionProgress(
      type: type ?? this.type,
      typeDictText: typeDictText ?? this.typeDictText,
      content: content ?? this.content,
    );
  }

  @override
  String toString() =>
      'OpinionProgress(type: $type, typeDictText: $typeDictText, content: $content)';

  @override
  List<Object> get props => [type, typeDictText, content];
}
