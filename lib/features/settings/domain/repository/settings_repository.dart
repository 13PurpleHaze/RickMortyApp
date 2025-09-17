abstract interface class SettingsRepository {
  bool isDarkThemeSelected();

  Future<void> setDarkThemeSelected(bool selected);
}
