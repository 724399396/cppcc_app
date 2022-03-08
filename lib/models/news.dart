import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String title;
  final String description;

  const News({
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [
        title,
        description,
      ];
}
