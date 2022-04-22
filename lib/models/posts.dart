import 'package:equatable/equatable.dart';

import 'package:cppcc_app/dto/post_type.dart';

class Posts extends Equatable {
  final String id;
  final PostType postType;
  final String title;
  final String? author;
  final String? content;
  final int? category;
  final String? cover;
  final int? hits;
  final String? appendix;
  final String createBy;
  final DateTime createTime;
  final String? categoryDictText;
  final bool read;

  const Posts({
    required this.id,
    required this.postType,
    required this.title,
    required this.author,
    required this.content,
    required this.category,
    required this.cover,
    required this.hits,
    required this.appendix,
    required this.createBy,
    required this.createTime,
    required this.categoryDictText,
    required this.read,
  });

  Posts copyWith({
    String? id,
    PostType? postType,
    String? title,
    String? author,
    String? content,
    int? category,
    String? cover,
    int? hits,
    String? appendix,
    String? createBy,
    DateTime? createTime,
    String? categoryDictText,
    bool? read,
  }) {
    return Posts(
      id: id ?? this.id,
      postType: postType ?? this.postType,
      title: title ?? this.title,
      author: author ?? this.author,
      content: content ?? this.content,
      category: category ?? this.category,
      cover: cover ?? this.cover,
      hits: hits ?? this.hits,
      appendix: appendix ?? this.appendix,
      createBy: createBy ?? this.createBy,
      createTime: createTime ?? this.createTime,
      categoryDictText: categoryDictText ?? this.categoryDictText,
      read: read ?? this.read,
    );
  }

  @override
  String toString() {
    return 'Posts(id: $id, postType: $postType, title: $title, author: $author, content: $content, category: $category, cover: $cover, hits: $hits, appendix: $appendix, createBy: $createBy, createTime: $createTime, categoryDictText: $categoryDictText, read: $read)';
  }

  @override
  List<Object> get props {
    return [
      id,
      postType,
      title,
      author ?? '',
      content ?? '',
      category ?? '',
      cover ?? '',
      hits ?? '',
      appendix ?? '',
      createBy,
      createTime,
      categoryDictText ?? '',
      read,
    ];
  }
}
