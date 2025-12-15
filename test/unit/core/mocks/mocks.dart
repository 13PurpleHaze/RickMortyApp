import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/episodes/episodes.dart';
import 'package:rick_morty_app/features/settings/settings.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

@GenerateMocks([
  Dio,
  CharacterRepository,
  EpisodeRepository,
  SettingsRepository,
  SharedPreferences,
  FavoriteRepository,
])
void main() {}
