import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/card_loteria.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/passed_cards.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/progress_bar_timer.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/widgets/bottom_appbar_section.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppTheme.primary,
          child: Column(
            children: [
              PassedCards(),
              CardLoteria(isSmallCard: false),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ProgressBarTimer()))
            ]
          )),
      ),
      bottomNavigationBar: BottomAppbarSection(),
    );
  }
}