import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loteria_app/core/constants/api_settings.dart';
import 'package:loteria_app/app/theme/app_theme.dart';
import 'package:loteria_app/shared/utils/dimention_size.dart';

class CardLoteria extends StatelessWidget {
  const CardLoteria({
    super.key,
    required this.isSmallCard,
    this.isCoverCard,
    this.imageUrl});

  final bool isSmallCard;
  final bool? isCoverCard;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final fullUrl = "${ApiSettings.fromEnv().storageImageUrl}$imageUrl";
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondary,
        boxShadow: isSmallCard
          ? []
          : [
              BoxShadow(
                color: AppTheme.grey,
                offset: Offset(0, 1)
              )],
        border: Border(
          bottom: BorderSide(
            color: AppTheme.secondary
          )
        ),
        borderRadius: BorderRadius.circular(
          DimentionSize.width(isSmallCard ? 5 : 20))
      ),
      padding: EdgeInsets.symmetric(
        horizontal: DimentionSize.width(
          isSmallCard ? 8 : 27),
        vertical: DimentionSize.height(
          isSmallCard ? 7 : 22)),
      child: SizedBox(
        width: DimentionSize.width(
            isSmallCard ? 40 : 193),
        height: DimentionSize.height(
            isSmallCard ? 64 : 226),
        child: isCoverCard == true
            ? SvgPicture.asset(
                'assets/img/card_diamond.svg',
                fit: BoxFit.cover,
              )
            : Image.network(
                fullUrl,
                fit: BoxFit.cover)),
    );
  }
}