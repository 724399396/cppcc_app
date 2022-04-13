import 'package:equatable/equatable.dart';


class Opinion extends Equatable {
  final String id;
  final String title;
  final String typeDictText;
  final String? author;
  final String? content;
  final int? status;
  final String createBy;
  final DateTime createTime;

  const Opinion({
    required this.id, 
    required this.title,
    required this.typeDictText,
    required this.author,
    required this.content,
    required this.status,
    required this.createBy,
    required this.createTime,
  });

  Opinion copyWith({
    String? id,
    String? title,
    String? typeDictText,
    String? author,
    String? content,
    int? status,
    String? createBy,
    DateTime? createTime,
  }) {
    return Opinion(
      id: id ?? this.id,
      title: title ?? this.title,
      typeDictText: typeDictText ?? this.typeDictText,
      author: author ?? this.author,
      content: content ?? this.content,
      status: status ?? this.status,
      createBy: createBy ?? this.createBy,
      createTime: createTime ?? this.createTime,
    );
  }

  @override
  String toString() {
    return 'Opinion(id: $id, title: $title, typeDictText: $typeDictText, author: $author, content: $content, status: $status, createBy: $createBy, createTime: $createTime)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      typeDictText,
      author ?? '',
      content ?? '',
      status ?? 0,
      createBy,
      createTime,
    ];
  }
}
