part of 'timer_bloc.dart';

class TimerState {
  final StatusTimer currentStatus;
  final int? duration;

  const TimerState({
    required this.currentStatus,
    this.duration,
  });

  TimerState copyWith({
    StatusTimer? currentStatus,
    int? duration,
  }){
    return TimerState(
      currentStatus: currentStatus ?? this.currentStatus,
      duration: duration ?? this.duration);
  }

  static TimerState initial() => TimerState(currentStatus: StatusTimer.initial);
}