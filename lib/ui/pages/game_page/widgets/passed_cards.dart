import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loteria_app/ui/bloc/deck/deck_bloc.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/card_loteria.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/utils/dimention_size.dart';

class PassedCards extends StatelessWidget {
  const PassedCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeckBloc, DeckState>(
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: DimentionSize.width(7),
            vertical: DimentionSize.height(10)),
          height: DimentionSize.height(58),
          child: Stack(
            children: [
              ListView.separated(
                itemCount: state.cardsPlayed.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final imageUrl = state.cardsPlayed[index].imageUrl;
                  return CardLoteria(isSmallCard: true, imageUrl: imageUrl);
                },
                separatorBuilder: (context, index) => SizedBox(
                  width: DimentionSize.width(10))),
              if (state.remainingCards != 0)
                Positioned(
                  right: 0, top: 0, bottom: 0,
                  child: Center(
                    child: Container(
                      width: DimentionSize.width(42),
                      height: DimentionSize.height(31),
                      decoration: BoxDecoration(
                        color: AppTheme.secondary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(18),
                          bottomLeft: Radius.circular(18)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2))]),
                      child: Center(
                        child: Text(
                          '- ${state.remainingCards}',
                          style: TextStyle(
                            fontSize: DimentionSize.width(14),
                            color: Colors.white,
                            fontWeight: FontWeight.bold))))),
                ),
            ],
          ),
        );
      }
    );
  }
}