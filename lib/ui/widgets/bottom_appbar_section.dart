import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/main.dart';
import 'package:loteria_app/ui/bloc/deck/deck_bloc.dart';
import 'package:loteria_app/ui/bloc/set/set_bloc.dart';
import 'package:loteria_app/ui/bloc/timer/timer_bloc.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/utils/dimention_size.dart';
import 'package:loteria_app/ui/utils/enums.dart';
import 'package:loteria_app/ui/utils/progress_bar_controller.dart';

class BottomAppbarSection extends StatelessWidget {
  const BottomAppbarSection({super.key, required this.controller});

  final ProgressBarController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        final StatusTimer status = state.currentStatus;
        return BlocBuilder<DeckBloc, DeckState>(
          builder: (context, stateDeck) {
            return BottomAppBar(
              height: DimentionSize.height(53),
              surfaceTintColor: AppTheme.secondary,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: DimentionSize.width(5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        final stateSet = context.read<SetBloc>().state as SetCargado;
                        final shuffledCards = stateSet.cardSetLocal.cards.toList()..shuffle();
                        context.read<DeckBloc>().add(ShuffleCards());
                        context.read<DeckBloc>().add(InitializeDeck(cards: shuffledCards));
                        
                        controller.reset();
                        context.read<TimerBloc>().add(ResetTimer(status: StatusTimer.initial));
                      },
                      child: Icon(
                        status == StatusTimer.initial
                          ? Icons.flip_camera_android_rounded
                          : Icons.replay_rounded,
                        size: DimentionSize.width(24)),
                    ),
                    Icon(
                      Icons.record_voice_over_sharp,
                      size: DimentionSize.width(24),
                      color: AppTheme.disabled),
                    InkWell(
                      onTap: () {
                        if (status == StatusTimer.running) {
                          controller.pause();
                          context.read<TimerBloc>().add(StopTimer(status: StatusTimer.paused));
                        } else if (status == StatusTimer.paused) {
                          controller.resume();
                          context.read<TimerBloc>().add(StopTimer(status: StatusTimer.running));
                        } else if (status == StatusTimer.completed) {
                          final stateSet = context.read<SetBloc>().state as SetCargado;
                          final shuffledCards = stateSet.cardSetLocal.cards.toList()..shuffle();
                          context.read<DeckBloc>().add(ShuffleCards());
                          context.read<DeckBloc>().add(InitializeDeck(cards: shuffledCards));
                          
                          controller.reset();
                          context.read<TimerBloc>().add(StopTimer(status: StatusTimer.initial));
                        } else {
                          controller.start();
                          context.read<TimerBloc>().add(StartTimer(status: StatusTimer.running));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.opaqueWhite,
                          borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 9),
                        child: Icon(
                          status == StatusTimer.running
                            ? Icons.pause_rounded
                            : status == StatusTimer.completed ||
                              stateDeck.remainingCards == 0
                                ? Icons.replay_rounded
                                : Icons.play_arrow_rounded,
                          size: DimentionSize.width(32),
                          color: Colors.black)),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<TimerBloc>().add(UpdateDuration(duration: state.duration));
                      },
                      child: Text(
                        '${state.duration.toString().padLeft(2, '0')}s',
                        style: TextStyle(
                          fontSize: DimentionSize.width(14))),
                    ),
                    Icon(
                      Icons.settings_rounded,
                      size: DimentionSize.width(24)),
                  ],
                )
              ),
            );
          }
        );
      }
    );
  }
}