import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/bloc/theme/theme_cubit.dart';
import 'package:rick_morty_app/bloc/theme/theme_state.dart';
import 'package:rick_morty_app/features/character_detail/bloc/character_detail_bloc.dart';
import 'package:rick_morty_app/features/characters/bloc/characters_bloc.dart';
import 'package:rick_morty_app/features/episodes/bloc/episodes_bloc.dart';
import 'package:rick_morty_app/features/episodes/repository/episodes_repository.dart';
import 'package:rick_morty_app/features/settings/repository/settings_repository.dart';
import 'package:rick_morty_app/repositories/characters_repository/characters_repository.dart';
import 'package:rick_morty_app/router/router.dart';
import 'package:rick_morty_app/ui/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();
  final charactersRepository = CharactersRepository();
  final episodesRepository = EpisodesRepository();

  final SharedPreferences preferences;

  App({super.key, required this.preferences});

  @override
  Widget build(BuildContext context) {
    final settingsRepository = SettingsRepository(preferences: preferences);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  CharactersBloc(charactersRepository: charactersRepository),
        ),
        BlocProvider(
          create:
              (context) => EpisodesBloc(episodesRepository: episodesRepository),
        ),
        BlocProvider(
          create:
              (context) => CharacterDetailBloc(
                charactersRepository: charactersRepository,
                episodesRepository: episodesRepository,
              ),
        ),
        BlocProvider(
          create:
              (context) => ThemeCubit(settingsRepository: settingsRepository),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            routerConfig: _appRouter.config(),
            title: 'Rick and Morty',
            theme: state.isDart ? darkTheme : lightTheme,
          );
        },
      ),
    );
  }
}
