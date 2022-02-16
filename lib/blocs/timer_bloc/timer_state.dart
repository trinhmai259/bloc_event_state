import 'dart:async';

import 'package:equatable/equatable.dart';

class TimerState extends Equatable {
  final int duration;

  TimerState(this.duration);

  @override
  // TODO: implement props
  List<Object?> get props => [duration];
}

class InitialState extends TimerState {
  InitialState(int duration) : super(duration);
}

class RunningState extends TimerState {
  RunningState(int duration) : super(duration);
}

class PauseState extends TimerState {
  PauseState(int duration) : super(duration);
}

class CompletedState extends TimerState {
  CompletedState() : super(0);
}
