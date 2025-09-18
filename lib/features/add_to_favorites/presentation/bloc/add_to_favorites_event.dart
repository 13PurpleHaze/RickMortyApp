part of 'add_to_favorites_bloc.dart';

sealed class AddToFavoritesEvent {}

final class ToggleAddToFavorites extends AddToFavoritesEvent {
  final Character character;

  ToggleAddToFavorites({required this.character});
}

final class LoadAddToFavorites extends AddToFavoritesEvent {
  final Character character;

  LoadAddToFavorites({required this.character});
}
