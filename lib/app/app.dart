import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_app/features/character_detail/bloc/character_detail_bloc.dart';
import 'package:rick_morty_app/features/characters/bloc/characters_bloc.dart';
import 'package:rick_morty_app/features/episodes/bloc/episodes_bloc.dart';
import 'package:rick_morty_app/features/episodes/repository/episodes_repository.dart';
import 'package:rick_morty_app/repositories/characters_repository/characters_repository.dart';
import 'package:rick_morty_app/router/router.dart';
import 'package:rick_morty_app/ui/theme/theme.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();
  final charactersRepository = CharactersRepository();
  final episodesRepository = EpisodesRepository();
  App({super.key});

  @override
  Widget build(BuildContext context) {
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
      ],
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        title: 'Rick and Morty',
        theme: appTheme,
      ),
    );
  }
}
