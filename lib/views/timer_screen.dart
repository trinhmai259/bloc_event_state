import 'package:bloc_event_state/blocs/timer_bloc/timer_bloc.dart';
import 'package:bloc_event_state/blocs/timer_bloc/timer_event.dart';
import 'package:bloc_event_state/blocs/timer_bloc/timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đồng hồ đếm ngược'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BlocProvider(
          create: (context) => TimerBloc(),
          child: BlocBuilder<TimerBloc, TimerState>(
            builder: (context, state) {
              final String minutesStr = ((state.duration / 60) % 60)
                  .floor()
                  .toString()
                  .padLeft(2, '0');
              final String secondsStr =
                  (state.duration % 60).floor().toString().padLeft(2, '0');

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // timer
                    Text(
                      '$minutesStr:$secondsStr',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: actionWidgets(state, context),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  actionWidgets(state, context) {
    final TimerBloc timerBloc = BlocProvider.of<TimerBloc>(context);
    if (state is InitialState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(StartEvent(state.duration)),
        )
      ];
    } else if (state is RunningState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timerBloc.add(PauseEvent()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(ResetEvent()),
        ),
      ];
    } else if (state is PauseState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.add(ResumeEvent()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(ResetEvent()),
        ),
      ];
    } else if (state is CompletedState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.add(ResetEvent()),
        )
      ];
    }
    return [];
  }
}
