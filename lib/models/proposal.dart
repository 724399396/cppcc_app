import 'package:equatable/equatable.dart';

class Proposal extends Equatable {
  final String id;
  final String title;
  final String author;
  final String content;
  final int status;
  final String statusDictText;
  final DateTime createTime;
  final bool read;
  final String createBy;
  final int year;
  const Proposal({
    required this.id,
    required this.title,
    required this.author,
    required this.content,
    required this.status,
    required this.statusDictText,
    required this.createTime,
    required this.read,
    required this.createBy,
    required this.year,
  });

  Proposal copyWith({
    String? id,
    String? title,
    String? author,
    String? content,
    int? status,
    String? statusDictText,
    DateTime? createTime,
    bool? read,
    String? createBy,
    int? year,
  }) {
    return Proposal(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      content: content ?? this.content,
      status: status ?? this.status,
      statusDictText: statusDictText ?? this.statusDictText,
      createTime: createTime ?? this.createTime,
      read: read ?? this.read,
      createBy: createBy ?? this.createBy,
      year: year ?? this.year,
    );
  }

  @override
  String toString() {
    return 'Proposal(id: $id, title: $title, author: $author, content: $content, status: $status, statusDictText: $statusDictText, createTime: $createTime, read: $read, createBy: $createBy, year: $year)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      author,
      content,
      status,
      statusDictText,
      createTime,
      read,
      createBy,
      year,
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
