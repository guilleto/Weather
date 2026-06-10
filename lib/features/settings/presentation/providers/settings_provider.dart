import 'package:flutter/material.dart';
import '../../../../core/design_system/tokens/app_typography.dart';
import '../../domain/repositories/settings_repository.dart';
import '../../domain/use_cases/save_font_preference.dart';
import '../../domain/use_cases/save_theme_preference.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsRepository _repository;
  final SaveThemePreference _saveTheme;
  final SaveFontPreference _saveFont;

  SettingsProvider(this._repository, this._saveTheme, this._saveFont);

  ThemeMode _themeMode = ThemeMode.light;
  AppFontFamily _fontFamily = AppFontFamily.fontA;

  ThemeMode get themeMode => _themeMode;
  AppFontFamily get fontFamily => _fontFamily;

  Future<void> loadPreferences() async {
    _themeMode = await _repository.getThemeMode();
    _fontFamily = await _repository.getFontFamily();
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _saveTheme(mode);
  }

  Future<void> setFontFamily(AppFontFamily family) async {
    _fontFamily = family;
    notifyListeners();
    await _saveFont(family);
  }
}
