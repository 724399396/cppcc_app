import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef GenericApiCall<T> = Future<void> Function(Emitter<T> emitter);

typedef SuccessCallback = void Function();

typedef FailCallback = void Function();

List<T> updateWithGenerateNewList<T>(List<T> data, bool Function(T value) test,
    T? Function(T? value) changer, {void Function(T? value)? matcherCallback}) {
  var prefix = data.takeWhile((e) => !test(e)).toList();
  var suffix = data.skipWhile((e) => !test(e)).skip(1).toList();
  var match = data.firstWhereOrNull((m) => test(m));
  if (match != null && matcherCallback != null) {
    matcherCallback(match);
  }
  var changed = changer(match);
  if (changed != null) {
    return prefix + [changed] + suffix;
  } else {
    return data;
  }
}
