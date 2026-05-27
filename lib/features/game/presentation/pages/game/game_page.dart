import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/core/enums/status_timer_enum.dart';
import 'package:loteria_app/features/game/presentation/pages/game/widgets/cards_in_play.dart';
import 'package:loteria_app/features/game/presentation/pages/game/widgets/passed_cards.dart';
import 'package:loteria_app/features/game/presentation/pages/game/widgets/progress_bar_timer.dart';
import 'package:loteria_app/features/game/presentation/bloc/deck/deck_bloc.dart';
import 'package:loteria_app/features/game/presentation/bloc/timer/timer_bloc.dart';
import 'package:loteria_app/features/set/presentation/bloc/set/set_bloc.dart';
import 'package:loteria_app/app/theme/app_theme.dart';
import 'package:loteria_app/shared/controllers/animated_out_controller.dart';
import 'package:loteria_app/core/services/loteria_speaker.dart';
import 'package:loteria_app/shared/controllers/progress_bar_controller.dart';
import 'package:loteria_app/shared/widgets/bottom_nav/bottom_appbar_section.dart';

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
                            final speaker = LoteriaSpeaker();
                            return CardsInPlay(
                              controller: _animatedOutController,
                              cards: state.visibleDeck,
                              hasCoverCard: state.hasCoverCard,
                              onCardPlayed: () => context.read<DeckBloc>()
                                  .add(PlayTopCard()),
                              onAnimationFinished: () {
                                if (state.remainingCards > 0) {
                                  context.read<TimerBloc>().add(StartTimer(status: StatusTimer.running));
                                  _progressController.start();
                                } else {
                                  context.read<TimerBloc>().add(StartTimer(status: StatusTimer.completed));
                                }
                                speaker.speak(state.visibleDeck[
                                  state.hasCoverCard ? 0 : 1].name);
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