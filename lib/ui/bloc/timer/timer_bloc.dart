import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/main.dart';
import 'package:loteria_app/ui/utils/enums.dart';

part 'timer_state.dart';
part 'timer_event.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState>{
  TimerBloc() : super(TimerState.initial()) {
    on<TimerEvent>((event, emit) {

    });

    on<UpdateDuration>((event, emit) {
      var duration = event.duration;
      if (duration == null) {
        // TODO: Crear modelo y recuperar la duración
        duration = 5;
        print("duration: $duration");
      } else {
        duration = (duration < 60) ? duration + 1 : 1;
      }
      emit(state.copyWith(duration: duration));
    });

    on<StartTimer>((event, emit) {
      logger.i('${event.status} - Iniciando timer...');
      emit(state.copyWith(currentStatus: event.status));
    });

    on<StopTimer>((event, emit) {
      logger.i("${event.status} - Deteniendo timer...");
      emit(state.copyWith(currentStatus: event.status));
    });

    on<ResetTimer>((event, emit) {
      logger.i("${event.status} - Reiniciando timer...");
      emit(state.copyWith(currentStatus: event.status));
    });

    on<ResumeTimer>((event, emit) {
      logger.i("${event.status} - Continuando timer...");
      emit(state.copyWith(currentStatus: event.status));
    });

    on<CompleteTimer>((event, emit) {
      logger.i("${event.status} - Finalizando timer...");
      emit(state.copyWith(currentStatus: event.status));
    });
  }
}