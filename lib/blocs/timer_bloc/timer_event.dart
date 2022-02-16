import 'package:equatable/equatable.dart';

class TimerEvent extends Equatable {
  const TimerEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StartEvent extends TimerEvent {
  final int duration;
  StartEvent(this.duration);
}

class RunEvent extends TimerEvent {
  final int duration;
  RunEvent(this.duration);
}

class PauseEvent extends TimerEvent {}

class ResumeEvent extends TimerEvent {}

class ResetEvent extends TimerEvent {}
