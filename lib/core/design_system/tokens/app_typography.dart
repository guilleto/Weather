import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppFontFamily { fontA, fontB }

abstract class AppTypography {
  static TextTheme buildTextTheme(AppFontFamily family, Color textPrimary, Color textSecondary) {
    final base = family == AppFontFamily.fontA
        ? GoogleFonts.nunitoTextTheme()
        : GoogleFonts.merriweatherTextTheme();

    return base.copyWith(
      displayLarge: _style(base.displayLarge, 48, FontWeight.bold, textPrimary),
      headlineLarge: _style(base.headlineLarge, 32, FontWeight.bold, textPrimary),
      headlineMedium: _style(base.headlineMedium, 24, FontWeight.w600, textPrimary),
      headlineSmall: _style(base.headlineSmall, 20, FontWeight.w600, textPrimary),
      bodyLarge: _style(base.bodyLarge, 16, FontWeight.normal, textPrimary),
      bodyMedium: _style(base.bodyMedium, 14, FontWeight.normal, textPrimary),
      bodySmall: _style(base.bodySmall, 12, FontWeight.normal, textSecondary),
      labelSmall: _style(base.labelSmall, 11, FontWeight.w500, textSecondary),
    );
  }

  static TextStyle _style(TextStyle? base, double size, FontWeight weight, Color color) {
    return (base ?? const TextStyle()).copyWith(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }
}
