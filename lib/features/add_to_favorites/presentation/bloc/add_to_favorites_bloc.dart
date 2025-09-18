import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

part 'add_to_favorites_event.dart';
part 'add_to_favorites_state.dart';

class AddToFavoritesBloc
    extends Bloc<AddToFavoritesEvent, AddToFavoritesState> {
  final FavoriteRepository _favoriteRepository;

  AddToFavoritesBloc({required FavoriteRepository favoriteRepository})
    : _favoriteRepository = favoriteRepository,
      super(AddToFavoritesInitial()) {
    on<ToggleAddToFavorites>(_toggle);
    on<LoadAddToFavorites>(_load);
  }

  Future<void> _load(
    LoadAddToFavorites event,
    Emitter<AddToFavoritesState> emit,
  ) async {
    try {
      emit(AddToFavoritesLoading());
      final isFavorite = await _favoriteRepository.isFavorite(
        event.character.id,
      );
      emit(AddToFavoritesLoaded(value: isFavorite));
    } catch (e) {
      emit(AddToFavoritesFailure());
    }
  }

  Future<void> _toggle(
    ToggleAddToFavorites event,
    Emitter<AddToFavoritesState> emit,
  ) async {
    try {
      emit(AddToFavoritesLoading());

      final isFavorite = await _favoriteRepository.isFavorite(
        event.character.id,
      );
      if (isFavorite) {
        await _favoriteRepository.removeFromFavorites(event.character.id);
      } else {
        await _favoriteRepository.addToFavorites(event.character);
      }
      emit(AddToFavoritesLoaded(value: !isFavorite));
    } catch (e) {
      emit(AddToFavoritesFailure());
    }
  }
}
