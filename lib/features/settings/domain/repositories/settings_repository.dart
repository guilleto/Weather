import 'package:flutter/material.dart';
import '../../../../core/design_system/tokens/app_typography.dart';

abstract class SettingsRepository {
  Future<ThemeMode> getThemeMode();
  Future<void> saveThemeMode(ThemeMode mode);
  Future<AppFontFamily> getFontFamily();
  Future<void> saveFontFamily(AppFontFamily family);
}
