import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/main.dart';
import 'package:loteria_app/ui/bloc/set/set_bloc.dart';
import 'package:loteria_app/ui/bloc/timer/timer_bloc.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/card_loteria.dart';
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
                children: [
                  PassedCards(),
                  CardLoteria(isSmallCard: false),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: ProgressBarTimer(controller: _progressController)))
                ]
              );
            }
          )),
      ),
      bottomNavigationBar: BottomAppbarSection(controller: _progressController),
    );
  }
}