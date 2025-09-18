import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/features/settings/settings.dart';
import './theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SettingsRepository _settingsRepository;

  ThemeCubit({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository,
      super(ThemeState(brightness: Brightness.light)) {
    _checkSelectedTheme();
  }

  void setThemeBrightness(Brightness brightness) async {
    emit(state.copyWith(brightness: brightness));
    await _settingsRepository.setDarkThemeSelected(
      brightness == Brightness.dark,
    );
  }

  void _checkSelectedTheme() {
    final brightness =
        _settingsRepository.isDarkThemeSelected()
            ? Brightness.dark
            : Brightness.light;
    emit(state.copyWith(brightness: brightness));
  }
}
