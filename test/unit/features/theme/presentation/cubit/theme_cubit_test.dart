import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_app/features/theme/presentation/cubit/theme_cubit.dart';

import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late MockSettingsRepository mockSettingsRepository;
  late ThemeCubit themeCubit;

  setUp(() {
    mockSettingsRepository = MockSettingsRepository();
  });

  test(
    'should initial state be light by default when repository returns false',
    () {
      when(mockSettingsRepository.isDarkThemeSelected()).thenReturn(false);
      themeCubit = ThemeCubit(settingsRepository: mockSettingsRepository);
      expect(themeCubit.state.brightness, Brightness.light);
    },
  );

  test(
    'setThemeBrightness should updates state and calls repository',
    () async {
      when(
        mockSettingsRepository.setDarkThemeSelected(true),
      ).thenAnswer((_) async => Future.value());
      when(mockSettingsRepository.isDarkThemeSelected()).thenReturn(true);

      themeCubit = ThemeCubit(settingsRepository: mockSettingsRepository);
      themeCubit.setThemeBrightness(Brightness.dark);

      expect(themeCubit.state.brightness, Brightness.dark);
      verify(mockSettingsRepository.setDarkThemeSelected(true)).called(1);
    },
  );
}
