import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/utils/dimention_size.dart';

class CardLoteria extends StatelessWidget {
  const CardLoteria({
    super.key,
    required this.isSmallCard});

  final bool isSmallCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondary,
        borderRadius: BorderRadius.circular(
          DimentionSize.width(20))
      ),
      padding: EdgeInsets.symmetric(
        horizontal: DimentionSize.width(
          isSmallCard ? 7 : 27),
        vertical: DimentionSize.height(
          isSmallCard ? 7 : 27)),
      child: SvgPicture.asset(
        'assets/img/card_diamond.svg',
        width: DimentionSize.width(
          isSmallCard ? 40 : 153),
        height: DimentionSize.height(
          isSmallCard ? 64 : 246)),
    );
  }
}