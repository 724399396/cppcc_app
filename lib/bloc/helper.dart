import 'package:flutter_bloc/flutter_bloc.dart';

typedef GenericApiCall<T> = Future<void> Function(Emitter<T> emitter);