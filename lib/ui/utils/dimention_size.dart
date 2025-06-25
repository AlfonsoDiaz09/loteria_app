import 'package:flutter/widgets.dart';

class DimentionSize {
  static late double screenWidth;
  static late double screenHeight;
  static late double blocWidth;
  static late double blocHeight;
  static bool isInitialized = false;

  static void init(BuildContext context) {
    if (isInitialized) return;

    final mediaQuery = MediaQuery.of(context);
    screenWidth = mediaQuery.size.width;
    screenHeight = mediaQuery.size.height;

    blocWidth = screenWidth / 320;
    blocHeight = screenHeight / 480;

    isInitialized = true;
  }
  static double width(double percent) => blocWidth * percent;
  static double height(double percent) => blocHeight * percent;
}