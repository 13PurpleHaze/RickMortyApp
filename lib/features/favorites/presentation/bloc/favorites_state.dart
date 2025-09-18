part of 'favorites_bloc.dart';

sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesLoaded extends FavoritesState {
  final List<Character> favorites;

  FavoritesLoaded({required this.favorites});
}

final class FavoritesFailure extends FavoritesState {
  final Object error;

  FavoritesFailure({required this.error});
}
