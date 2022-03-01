import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cppcc_app/utils/ticker.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker = Ticker();
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc() : super(const TimerInitial(_duration)) {
    on<TimerStarted>(
      (event, emit) => _mapTimerStartedToState(event, emit),
    );
    on<TimerTicked>(
      (event, emit) => _mapTimerTickedToState(event, emit),
    );
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _mapTimerStartedToState(TimerStarted start, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(start.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: start.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void _mapTimerTickedToState(TimerTicked tick, Emitter<TimerState> emit) {
    emit(tick.duration > 0
        ? TimerRunInProgress(tick.duration)
        : const TimerRunComplete());
  }
}
