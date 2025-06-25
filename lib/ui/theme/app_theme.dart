import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppTheme {
  static const Color primary = Color(0xFF1E1E1E);
  static const Color secondary = Color(0xFF363636);
  static const Color disabled = Color(0xffC2CCC6);
  static const Color grey = Color(0xFF686868);
  static const Color opaqueWhite = Color(0xFFD9D9D9);

  static ThemeData darkTheme(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    const baseWidth = 480;
    final scale = screenWidth / baseWidth;

    TextStyle scaledStyle(
        double size, {
          FontWeight fontWeight = FontWeight.normal,
          Color? color,
        }) {
      return TextStyle(
        fontSize: size * scale,
        fontWeight: fontWeight,
        color: color,
      );
    }

    return ThemeData.dark().copyWith(
      primaryColor: primary,
      textTheme: TextTheme(
        // Títulos principales
        headlineLarge: scaledStyle(28.0, fontWeight: FontWeight.bold),
        headlineMedium: scaledStyle(24.0, fontWeight: FontWeight.w600),
        
        // Títulos secundarios (cards, modales)
        titleLarge: scaledStyle(20.0, fontWeight: FontWeight.w600, color: opaqueWhite),
        titleMedium: scaledStyle(18.0, fontWeight: FontWeight.w600, color: opaqueWhite),

        // Texto normal
        bodyLarge: scaledStyle(16.0, color: opaqueWhite),
        bodyMedium: scaledStyle(14.0, color: opaqueWhite),

        // Labels (botones, campos)
        labelLarge: scaledStyle(14.0, fontWeight: FontWeight.w500, color: opaqueWhite),
        labelSmall: scaledStyle(12.0, color: opaqueWhite),
      ),
    );
  }
}