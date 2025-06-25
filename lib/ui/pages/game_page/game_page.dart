import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loteria_app/ui/theme/app_theme.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppTheme.primary,
        child: Center(child: Text('Game Page'))),
    );
  }
}