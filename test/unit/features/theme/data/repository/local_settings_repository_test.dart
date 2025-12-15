import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_app/features/settings/settings.dart';

import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late LocalSettingsRepository sut;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    sut = LocalSettingsRepository(preferences: mockSharedPreferences);
  });

  test('isDarkThemeSelected should return false on init', () {
    when(
      mockSharedPreferences.getBool(
        LocalSettingsRepository.isDarkThemeSelectedKey,
      ),
    ).thenReturn(false);

    final isDarkThemeSelected = sut.isDarkThemeSelected();
    expect(isDarkThemeSelected, false);
    verify(
      mockSharedPreferences.getBool(
        LocalSettingsRepository.isDarkThemeSelectedKey,
      ),
    ).called(1);
  });

  test('setDarkThemeSelected should set theme', () {
    when(
      mockSharedPreferences.setBool(
        LocalSettingsRepository.isDarkThemeSelectedKey,
        true,
      ),
    ).thenAnswer((_) async => true);
    when(
      mockSharedPreferences.getBool(
        LocalSettingsRepository.isDarkThemeSelectedKey,
      ),
    ).thenReturn(true);

    sut.setDarkThemeSelected(true);

    final isDarkThemeSelected = sut.isDarkThemeSelected();
    expect(isDarkThemeSelected, true);
    verify(
      mockSharedPreferences.setBool(
        LocalSettingsRepository.isDarkThemeSelectedKey,
        true,
      ),
    ).called(1);
    verify(
      mockSharedPreferences.getBool(
        LocalSettingsRepository.isDarkThemeSelectedKey,
      ),
    ).called(1);
  });
}
