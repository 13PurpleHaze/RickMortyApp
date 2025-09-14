import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences preferences;

  SettingsRepository({required this.preferences});

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';

  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }
}
