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
import 'package:loteria_app/ui/utils/progress_bar_controller.dart';
import 'package:loteria_app/ui/widgets/bottom_appbar_section.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final ProgressBarController _progressController = ProgressBarController();
  
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
                  BlocBuilder<SetBloc, SetState>(
                    builder: (context, stateSet) {
                      if (stateSet is! SetCargado) return SizedBox.shrink();
                      context.read<DeckBloc>().add(InitializeDeck(
                          cards: stateSet.cardSetLocal.cards));
                      return BlocBuilder<DeckBloc, DeckState>(
                        builder: (context, state) {
                          return state.visibleDeck.isEmpty
                            ? const Center(child: Text('Sin cartas'))
                            : CardsInPlay(
                                cards: state.visibleDeck,
                                onCardPlayed: () => context.read<DeckBloc>()
                                    .add(PlayTopCard()));
                        }
                      );
                    }
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ProgressBarTimer(controller: _progressController))
                ]
              );
            }
          )),
      ),
      bottomNavigationBar: BottomAppbarSection(controller: _progressController),
    );
  }
}