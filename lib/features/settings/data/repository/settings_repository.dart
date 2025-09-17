import 'package:shared_preferences/shared_preferences.dart';

import 'package:rick_morty_app/features/settings/domain/repository/repository.dart';

class LocalSettingsRepository implements SettingsRepository {
  final SharedPreferences preferences;

  LocalSettingsRepository({required this.preferences});

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';

  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }
}
