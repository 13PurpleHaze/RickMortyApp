import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/core/ui/ui.dart';
import 'package:rick_morty_app/features/add_to_favorites/add_to_favorites.dart';

import '../bloc/character_detail_bloc.dart';
import '../widgets/widgets.dart';

@RoutePage()
class CharacterDetailScreen extends StatefulWidget {
  final int id;

  const CharacterDetailScreen({super.key, required this.id});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<CharacterDetailBloc>(
      context,
    ).add(LoadCharacterDetail(id: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocBuilder<CharacterDetailBloc, CharacterDetailState>(
          builder: (context, state) {
            return switch (state) {
              CharacterDetailLoading _ => CustomScrollView(
                slivers: [
                  SliverFillRemaining(child: PlatformBackgroundLoader()),
                ],
              ),
              CharacterDetailLoaded state => CustomScrollView(
                slivers: [
                  CustomAppBar(
                    imageUrl: state.character.image,
                    title: state.character.name,
                    trailing: ToggleFavoritesButton(character: state.character),
                  ),
                  CharacteristicsList(
                    itemCount: state.character.characteristics.length + 1,
                    characteristics: state.character.characteristics,
                  ),
                  EpisodesList(episodes: state.episodes),
                ],
              ),
              CharacterDetailFailure _ => CustomScrollView(
                slivers: [
                  PlatformAppBar(title: 'Character'),
                  SliverFillRemaining(
                    child: TextBanner(
                      title: 'Error occurred',
                      description:
                          'Sorry, something went wrong, please try again later',
                    ),
                  ),
                ],
              ),
              CharacterDetailState _ => CustomScrollView(
                slivers: [
                  SliverFillRemaining(child: PlatformBackgroundLoader()),
                ],
              ),
            };
          },
        ),
      ),
    );
  }
}
