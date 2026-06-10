import 'package:flutter/material.dart';

abstract class AppElevation {
  static const double level0 = 0.0;
  static const double level1 = 2.0;
  static const double level2 = 4.0;
  static const double level3 = 8.0;

  static List<BoxShadow> shadow(double level, Color shadowColor) {
    if (level <= 0) return [];
    return [
      BoxShadow(
        color: shadowColor.withValues(alpha: 0.08 * level),
        blurRadius: level * 4,
        spreadRadius: level,
        offset: Offset(0, level),
      ),
    ];
  }
}
