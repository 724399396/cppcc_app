import 'package:equatable/equatable.dart';

class GuanduHistoricalClue extends Equatable {
  final String id;
  final String content;
  final String createBy;
  final String createTime;
  final String phone;
  final String title;
  final String provider;
  final String unit;
  final bool read;
  const GuanduHistoricalClue({
    required this.id,
    required this.content,
    required this.createBy,
    required this.createTime,
    required this.phone,
    required this.title,
    required this.provider,
    required this.unit,
    required this.read,
  });

  GuanduHistoricalClue copyWith({
    String? id,
    String? content,
    String? createBy,
    String? createTime,
    String? phone,
    String? title,
    String? provider,
    String? unit,
    bool? read,
  }) {
    return GuanduHistoricalClue(
      id: id ?? this.id,
      content: content ?? this.content,
      createBy: createBy ?? this.createBy,
      createTime: createTime ?? this.createTime,
      phone: phone ?? this.phone,
      title: title ?? this.title,
      provider: provider ?? this.provider,
      unit: unit ?? this.unit,
      read: read ?? this.read,
    );
  }

  @override
  String toString() {
    return 'GuanduHistoricalClue(id: $id, content: $content, createBy: $createBy, createTime: $createTime, phone: $phone, title: $title, provider: $provider, unit: $unit, read: $read)';
  }

  @override
  List<Object> get props {
    return [
      id,
      content,
      createBy,
      createTime,
      phone,
      title,
      provider,
      unit,
      read,
    ];
  }
}
