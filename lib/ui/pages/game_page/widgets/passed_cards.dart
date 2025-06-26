import 'package:flutter/material.dart';
import 'package:loteria_app/ui/pages/game_page/widgets/card_loteria.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/utils/dimention_size.dart';

class PassedCards extends StatelessWidget {
  const PassedCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: DimentionSize.width(7),
        vertical: DimentionSize.height(10)),
      height: DimentionSize.height(78),
      child: Stack(
        children: [
          ListView.separated(
            itemCount: 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CardLoteria(isSmallCard: true);
            },
            separatorBuilder: (context, index) => SizedBox(
              width: DimentionSize.width(10))),
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
                    '- 54',
                    style: TextStyle(
                      fontSize: DimentionSize.width(14),
                      color: Colors.white,
                      fontWeight: FontWeight.bold))))),
          ),
        ],
      ),
    );
  }
}