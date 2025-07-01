import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/main.dart';
import 'package:loteria_app/ui/bloc/deck/deck_bloc.dart';
import 'package:loteria_app/ui/bloc/set/set_bloc.dart';
import 'package:loteria_app/ui/bloc/timer/timer_bloc.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/cards_in_play.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/passed_cards.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/progress_bar_timer.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/utils/animated_out_controller.dart';
import 'package:loteria_app/ui/utils/enums.dart';
import 'package:loteria_app/ui/utils/progress_bar_controller.dart';
import 'package:loteria_app/ui/widgets/bottom_appbar_section.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final ProgressBarController _progressController = ProgressBarController();
  final AnimatedOutController _animatedOutController = AnimatedOutController();
  
  @override
  void initState() {
    context.read<TimerBloc>().add(UpdateDuration());
    context.read<SetBloc>().add(SearchDefaultSets());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppTheme.primary,
          child: BlocBuilder<TimerBloc, TimerState>(
            builder: (context, state) {
              if (state.duration == null) return SizedBox.shrink();
              
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PassedCards(),
                  Expanded(
                    child: BlocConsumer<SetBloc, SetState>(
                      listenWhen: (_, current) => current is SetCargado,
                      listener: (context, state) {
                        final setState = state as SetCargado;
                        context.read<DeckBloc>().add(
                          ShuffleCards());
                        final shuffledCards = setState.cardSetLocal.cards.toList()..shuffle();
                        context.read<DeckBloc>().add(
                          InitializeDeck(cards: shuffledCards));
                      },
                      builder: (context, stateSet) {
                        if (stateSet is! SetCargado) return SizedBox.shrink();
                        return BlocBuilder<DeckBloc, DeckState>(
                          builder: (context, state) {
                            return state.visibleDeck.isEmpty
                              ? const Center(child: Text('Sin cartas'))
                              : CardsInPlay(
                                  controller: _animatedOutController,
                                  cards: state.visibleDeck,
                                  onCardPlayed: () => context.read<DeckBloc>()
                                      .add(PlayTopCard()),
                                  onAnimationFinished: () {
                                    context.read<TimerBloc>().add(StartTimer(status: StatusTimer.running));
                                    _progressController.start();
                                  });
                          }
                        );
                      }
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ProgressBarTimer(
                      progressController: _progressController,
                      animatedOutController: _animatedOutController))
                ]
              );
            }
          )),
      ),
      bottomNavigationBar: BottomAppbarSection(controller: _progressController),
    );
  }
}