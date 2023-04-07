import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFfaebd7);
  static const Color secondaryColor = Color(0xFFfdf5e6);
  static const Color titleColor = Color(0xff4d4843);
}

class CustomMaterialColor {
  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  static final MaterialColor primaryMaterialColor =
      createMaterialColor(AppColors.primaryColor);
  static final MaterialColor secondaryMaterialColor =
      createMaterialColor(AppColors.secondaryColor);
  static final MaterialColor titleMaterialColor =
      createMaterialColor(AppColors.titleColor);
}
