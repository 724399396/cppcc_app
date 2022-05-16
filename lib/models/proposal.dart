import 'package:equatable/equatable.dart';

class Proposal extends Equatable {
  final String id;
  final String title;
  final String author;
  final String authorId;
  final String content;
  final int status;
  final String statusDictText;
  final DateTime createTime;
  final bool read;
  final String createBy;
  final int year;
  final List<ProposalProgress> progress;

  const Proposal({
    required this.id,
    required this.title,
    required this.author,
    required this.authorId,
    required this.content,
    required this.status,
    required this.statusDictText,
    required this.createTime,
    required this.read,
    required this.createBy,
    required this.year,
    this.progress = const [],
  });

  Proposal copyWith({
    String? id,
    String? title,
    String? author,
    String? authorId,
    String? content,
    int? status,
    String? statusDictText,
    DateTime? createTime,
    bool? read,
    String? createBy,
    int? year,
    List<ProposalProgress>? progress,
  }) {
    return Proposal(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      authorId: authorId ?? this.authorId,
      content: content ?? this.content,
      status: status ?? this.status,
      statusDictText: statusDictText ?? this.statusDictText,
      createTime: createTime ?? this.createTime,
      read: read ?? this.read,
      createBy: createBy ?? this.createBy,
      year: year ?? this.year,
      progress: progress ?? this.progress,
    );
  }

  @override
  String toString() {
    return 'Proposal(id: $id, title: $title, author: $author, authorId: $authorId, content: $content, status: $status, statusDictText: $statusDictText, createTime: $createTime, read: $read, createBy: $createBy, year: $year, progress: $progress)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      author,
      authorId,
      content,
      status,
      statusDictText,
      createTime,
      read,
      createBy,
      year,
      progress,
    ];
  }
}

enum ProposalListType {
  year,
  excellent,
}

extension ProposalListTypeExtension on ProposalListType {
  String get description {
    switch (this) {
      case ProposalListType.year:
        return '年度提案';
      case ProposalListType.excellent:
        return '优秀提案';
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

class ProposalProgress extends Equatable {
  final int type;
  final String typeDictText;
  final List<KeyValue> content;
  const ProposalProgress({
    required this.typeDictText,
    required this.content,
    required this.type,
  });

  ProposalProgress copyWith({
    int? type,
    String? typeDictText,
    List<KeyValue>? content,
  }) {
    return ProposalProgress(
      type: type ?? this.type,
      typeDictText: typeDictText ?? this.typeDictText,
      content: content ?? this.content,
    );
  }

  @override
  String toString() =>
      'ProposalProgress(type: $type, typeDictText: $typeDictText, content: $content)';

  @override
  List<Object> get props => [type, typeDictText, content];
}
