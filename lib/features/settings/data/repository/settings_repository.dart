import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/domain.dart';

class LocalSettingsRepository implements SettingsRepository {
  final SharedPreferences preferences;

  LocalSettingsRepository({required this.preferences});

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';

  @override
  bool isDarkThemeSelected() {
    final selected = preferences.getBool(_isDarkThemeSelectedKey);
    return selected ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await preferences.setBool(_isDarkThemeSelectedKey, selected);
  }
}
