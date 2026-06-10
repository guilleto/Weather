import 'package:flutter/material.dart';
import '../repositories/settings_repository.dart';

class SaveThemePreference {
  final SettingsRepository _repository;
  const SaveThemePreference(this._repository);

  Future<void> call(ThemeMode mode) => _repository.saveThemeMode(mode);
}
