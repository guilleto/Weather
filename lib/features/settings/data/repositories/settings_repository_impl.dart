import 'package:flutter/material.dart';
import '../../../../core/design_system/tokens/app_typography.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource _local;
  const SettingsRepositoryImpl(this._local);

  @override
  Future<ThemeMode> getThemeMode() => _local.getThemeMode();

  @override
  Future<void> saveThemeMode(ThemeMode mode) => _local.saveThemeMode(mode);

  @override
  Future<AppFontFamily> getFontFamily() => _local.getFontFamily();

  @override
  Future<void> saveFontFamily(AppFontFamily family) => _local.saveFontFamily(family);
}
