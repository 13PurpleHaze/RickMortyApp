import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

class ToggleFavoritesButton extends StatelessWidget {
  final Character character;

  const ToggleFavoritesButton({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (previous, current) {
        return current is! FavoriteToggledFailure;
      },
      builder: (context, state) {
        final isFavorite =
            state is FavoritesLoaded &&
            state.favoriteIds.contains(character.id);
        return IconButton(
          onPressed: () => _toggle(context, character),
          icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
          color:
              isFavorite
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).iconTheme.color,
        );
      },
    );
  }

  _toggle(BuildContext context, Character character) {
    BlocProvider.of<FavoritesBloc>(
      context,
    ).add(ToggleFavorite(character: character));
  }
}
