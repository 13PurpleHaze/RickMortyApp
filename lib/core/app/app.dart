import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/core/db/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rick_morty_app/core/ui/ui.dart';
import 'package:rick_morty_app/core/router/router.dart';

import 'package:rick_morty_app/features/theme/theme.dart';
import 'package:rick_morty_app/features/character_detail/character_detail.dart';
import 'package:rick_morty_app/features/characters/characters.dart';
import 'package:rick_morty_app/features/episodes/episodes.dart';
import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/settings/settings.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();
  final Dio dio;
  final SharedPreferences preferences;
  final Map<String, String> config;
  final AppDatabase database;

  App({
    super.key,
    required this.preferences,
    required this.dio,

    required this.config,
    required this.database,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CharacterRepository>(
          create: (context) => RemoteCharactersRepository(dio: dio),
        ),
        RepositoryProvider<EpisodeRepository>(
          create: (context) => RemoteEpisodeRepository(dio: dio),
        ),
        RepositoryProvider<SettingsRepository>(
          create:
              (context) => LocalSettingsRepository(preferences: preferences),
        ),
        RepositoryProvider<FavoriteRepository>(
          create: (context) => LocalFavoritesRepository(database: database),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => CharactersBloc(
                  characterRepository: context.read<CharacterRepository>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => EpisodesBloc(
                  episodeRepository: context.read<EpisodeRepository>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => CharacterDetailBloc(
                  characterRepository: context.read<CharacterRepository>(),
                  episodeRepository: context.read<EpisodeRepository>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => ThemeCubit(
                  settingsRepository: context.read<SettingsRepository>(),
                ),
          ),
          BlocProvider(
            create:
                (context) => FavoritesBloc(
                  favoriteRepository: context.read<FavoriteRepository>(),
                ),
          ),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: _appRouter.config(),
              title: config['APP_NAME'],
              theme: state.isDart ? darkTheme : lightTheme,
            );
          },
        ),
      ),
    );
  }
}
