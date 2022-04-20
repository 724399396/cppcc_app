import 'package:equatable/equatable.dart';

class TwoMeetings extends Equatable {
  final String id;
  final String title;
  final String? cover;
  final String content;
  final String createAt;
  final int hits;
  const TwoMeetings({
    required this.id,
    required this.title,
    required this.cover,
    required this.content,
    required this.createAt,
    required this.hits,
  });

  TwoMeetings copyWith({
    String? id,
    String? title,
    String? cover,
    String? content,
    String? createAt,
    int? hits,
  }) {
    return TwoMeetings(
      id: id ?? this.id,
      title: title ?? this.title,
      cover: cover ?? this.cover,
      content: content ?? this.content,
      createAt: createAt ?? this.createAt,
      hits: hits ?? this.hits,
    );
  }

  @override
  String toString() {
    return 'TwoMeetings(id: $id, title: $title, cover: $cover, content: $content, createAt: $createAt, hits: $hits)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      cover ?? '',
      content,
      createAt,
      hits,
    ];
  }
}
