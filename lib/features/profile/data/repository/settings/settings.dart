import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/features/profile/domain/repository/settings/settings.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SharedPreferences _sharedPreferences;

  SettingsRepositoryImpl({required SharedPreferences sharedPreferences})
    : _sharedPreferences = sharedPreferences;

  static const String _darkModeKey = 'dark_mode';

  @override
  bool getDarkMode() {
    final selected = _sharedPreferences.getBool(_darkModeKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    await _sharedPreferences.setBool(_darkModeKey, isDarkMode);
  }
}
