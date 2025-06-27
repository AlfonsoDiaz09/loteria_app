import 'package:flutter/material.dart';
import 'package:loteria_app/core/constants/api_settings.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/utils/dimention_size.dart';

class CardLoteria extends StatelessWidget {
  const CardLoteria({
    super.key,
    required this.isSmallCard,
    required this.imageUrl});

  final bool isSmallCard;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final fullUrl = "${ApiSettings.fromEnv().storageImageUrl}$imageUrl";
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.secondary,
        boxShadow: [
          BoxShadow(
            color: AppTheme.grey,
            offset: Offset(0, 1)
          )
        ],
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
      child: Image.network(
        fullUrl,
        width: DimentionSize.width(
          isSmallCard ? 40 : 193),
        height: DimentionSize.height(
          isSmallCard ? 64 : 226)),
    );
  }
}