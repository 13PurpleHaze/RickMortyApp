part of 'add_to_favorites_bloc.dart';

sealed class AddToFavoritesState {}

final class AddToFavoritesInitial extends AddToFavoritesState {}

final class AddToFavoritesLoading extends AddToFavoritesState {}

final class AddToFavoritesLoaded extends AddToFavoritesState {
  final bool value;

  AddToFavoritesLoaded({required this.value});
}

final class AddToFavoritesFailure extends AddToFavoritesState {}
