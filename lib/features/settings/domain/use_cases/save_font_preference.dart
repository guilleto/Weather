import '../../../../core/design_system/tokens/app_typography.dart';
import '../repositories/settings_repository.dart';

class SaveFontPreference {
  final SettingsRepository _repository;
  const SaveFontPreference(this._repository);

  Future<void> call(AppFontFamily family) => _repository.saveFontFamily(family);
}
