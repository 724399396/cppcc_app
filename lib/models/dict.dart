import 'package:equatable/equatable.dart';

class Dict extends Equatable {
  final String itemValue;
  final String itemText;

  const Dict({
    required this.itemValue,
    required this.itemText,
  });

  @override
  String toString() => 'Dict(itemValue: $itemValue, itemText: $itemText)';

  @override
  List<Object> get props => [itemValue];
}
