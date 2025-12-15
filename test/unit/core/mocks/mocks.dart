import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/episodes/episodes.dart';
import 'package:rick_morty_app/features/settings/settings.dart';

@GenerateMocks([
  Dio,
  CharacterRepository,
  EpisodeRepository,
  SettingsRepository,
])
void main() {}
