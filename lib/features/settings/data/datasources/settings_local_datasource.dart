import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/design_system/tokens/app_typography.dart';

class SettingsLocalDatasource {
  static const _themeKey = 'theme_mode';
  static const _fontKey = 'font_family';

  Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_themeKey);
    return switch (value) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    final value = switch (mode) {
      ThemeMode.dark => 'dark',
      ThemeMode.light => 'light',
      ThemeMode.system => 'system',
    };
    await prefs.setString(_themeKey, value);
  }

  Future<AppFontFamily> getFontFamily() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_fontKey);
    return value == 'fontB' ? AppFontFamily.fontB : AppFontFamily.fontA;
  }

  Future<void> saveFontFamily(AppFontFamily family) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontKey, family.name);
  }
}
