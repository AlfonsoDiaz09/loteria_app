import 'package:flutter/material.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';
import 'package:loteria_app/ui/utils/dimention_size.dart';

class BottomAppbarSection extends StatelessWidget {
  const BottomAppbarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isPlaying = false;
    return BottomAppBar(
      height: DimentionSize.height(41),
      surfaceTintColor: AppTheme.secondary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.replay_rounded,
            size: DimentionSize.width(24)),
          Icon(
            Icons.record_voice_over_sharp,
            size: DimentionSize.width(24),
            color: AppTheme.disabled),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.opaqueWhite,
              borderRadius: BorderRadius.circular(8)),
            padding: EdgeInsets.symmetric(
              horizontal: 4,
              vertical: 3),
            child: Icon(
              isPlaying 
              ? Icons.pause_rounded
              : Icons.play_arrow_rounded,
              size: DimentionSize.width(24),
              color: Colors.black)),
          Text(
            '03s',
            style: TextStyle(
              fontSize: DimentionSize.width(14))),
          Icon(
            Icons.settings_rounded,
            size: DimentionSize.width(24)),
        ],
      ),
    );
  }
}