import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/features/add_to_favorites/add_to_favorites.dart';
import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

class ToggleFavoritesButton extends StatefulWidget {
  final Character character;
  final VoidCallback? onRemoved;

  const ToggleFavoritesButton({
    super.key,
    required this.character,
    this.onRemoved,
  });

  @override
  State<ToggleFavoritesButton> createState() => _ToggleFavoritesButtonState();
}

class _ToggleFavoritesButtonState extends State<ToggleFavoritesButton> {
  @override
  void initState() {
    BlocProvider.of<AddToFavoritesBloc>(
      context,
    ).add(LoadAddToFavorites(character: widget.character));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddToFavoritesBloc, AddToFavoritesState>(
      listener: (context, state) {
        if (state is AddToFavoritesLoaded) {
          context.read<FavoritesBloc>().add(LoadFavorites());
        }
      },
      child: BlocBuilder<AddToFavoritesBloc, AddToFavoritesState>(
        builder: (context, state) {
          return switch (state) {
            AddToFavoritesLoaded state => IconButton(
              onPressed: () => _toggle(context, widget.character),
              icon: Icon(state.value ? Icons.favorite : Icons.favorite_border),
              color:
                  state.value
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).iconTheme.color,
            ),
            _ => IconButton(
              onPressed: () => _toggle(context, widget.character),
              icon: Icon(Icons.favorite_border),
              color: Theme.of(context).iconTheme.color,
            ),
          };
        },
      ),
    );
  }

  _toggle(BuildContext context, Character character) {
    widget.onRemoved?.call();
    BlocProvider.of<AddToFavoritesBloc>(
      context,
    ).add(ToggleAddToFavorites(character: character));
  }
}
