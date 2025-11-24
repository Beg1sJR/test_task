abstract interface class SettingsRepository {
  Future<void> setDarkMode(bool isDarkMode);
  bool getDarkMode();
}
