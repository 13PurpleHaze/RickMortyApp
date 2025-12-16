part of 'favorites_bloc.dart';

class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<Character> favorites;
  final List<int> favoriteIds;

  FavoritesLoaded({required this.favoriteIds, required this.favorites});
}

final class FavoritesFailure extends FavoritesState {
  final Object error;

  FavoritesFailure({required this.error});
}

final class FavoriteToggledFailure extends FavoritesState {
  final Object error;

  FavoriteToggledFailure({required this.error});
}
