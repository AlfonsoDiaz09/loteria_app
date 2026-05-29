part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent {}

class UpdateDuration extends TimerEvent {
  final int? duration;

  UpdateDuration({ this.duration });
}

class StartTimer extends TimerEvent {
  final StatusTimer status;

  StartTimer({ required this.status });
}

class StopTimer extends TimerEvent {
  final StatusTimer status;

  StopTimer({ required this.status });
}

class ResetTimer extends TimerEvent {
  final StatusTimer status;

  ResetTimer({ required this.status });
}

class ResumeTimer extends TimerEvent {
  final StatusTimer status;

  ResumeTimer({ required this.status });
}

class CompleteTimer extends TimerEvent {
  final StatusTimer status;

  CompleteTimer({ required this.status });
}
