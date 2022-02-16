import 'dart:async';
import 'package:bloc_event_state/blocs/timer_bloc/timer_event.dart';
import 'package:bloc_event_state/blocs/timer_bloc/timer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static int _InitDuration = 60;
  TimerBloc() : super(InitialState(_InitDuration));

  StreamSubscription<int>? _timerSubscription;

  @override
  Stream<TimerState> mapEventToState(TimerEvent event) async* {
    if (event is StartEvent) {
      yield RunningState(event.duration);
      _timerSubscription?.cancel();
      _timerSubscription =
          tick(event.duration).listen((duration) => add(RunEvent(duration)));
    } else if (event is RunEvent) {
      yield event.duration > 0
          ? RunningState(event.duration)
          : CompletedState();
    } else if (event is PauseEvent) {
      if (state is RunningState) {
        _timerSubscription?.pause();
        yield PauseState(state.duration);
      }
    } else if (event is ResumeEvent) {
      if (state is PauseState) {
        _timerSubscription?.resume();
        yield RunningState(state.duration);
      }
    } else if (event is ResetEvent) {
      _timerSubscription?.cancel();
      yield InitialState(_InitDuration);
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    _timerSubscription?.cancel();
    return super.close();
  }

  Stream<int> tick(int ticks) {
    return Stream.periodic(Duration(seconds: 1), (x) => ticks - x - 1)
        .take(ticks);
  }
}
