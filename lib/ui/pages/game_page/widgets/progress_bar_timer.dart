import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/main.dart';
import 'package:loteria_app/ui/bloc/deck/deck_bloc.dart';
import 'package:loteria_app/ui/bloc/timer/timer_bloc.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/utils/enums.dart';
import 'package:loteria_app/ui/utils/progress_bar_controller.dart';

class ProgressBarTimer extends StatefulWidget {
  const ProgressBarTimer({
    super.key,
    required this.controller});

  final ProgressBarController controller;

  @override
  State<ProgressBarTimer> createState() => _ProgressBarTimerState();
}

class _ProgressBarTimerState extends State<ProgressBarTimer> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Duration duration;

  @override
  void initState() {
    final stateBlocTimer = context.read<TimerBloc>().state;
    duration = Duration(seconds: stateBlocTimer.duration!);
    _animationController = AnimationController(
      vsync: this,
      duration: duration);

    widget.controller.attach(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final statusDeckBloc = context.read<DeckBloc>().state;
        context.read<DeckBloc>().add(PlayTopCard());
        context.read<TimerBloc>().add(CompleteTimer(status: StatusTimer.completed));
        if (statusDeckBloc.visibleDeck.isNotEmpty) {
          widget.controller.start();
          context.read<TimerBloc>().add(StartTimer(status: StatusTimer.running));
        } 
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ProgressBarTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newDuration = Duration(seconds: context.read<TimerBloc>().state.duration!);
    if (_animationController.duration != newDuration &&
        _animationController.isAnimating) {
      final percentComplete = _animationController.value;
      _animationController.duration = newDuration;
      _animationController.forward(from: percentComplete);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      builder: (context, state) {
        return AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Container(
              width: double.infinity,
              height: 6,
              decoration: BoxDecoration(
                color: AppTheme.grey,
                borderRadius: BorderRadius.circular(4),
              ),
              child: FractionallySizedBox(
                widthFactor: _animationController.value,
                alignment: Alignment.centerLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
}