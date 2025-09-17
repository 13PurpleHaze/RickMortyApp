part of 'characters_bloc.dart';

class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;
  final bool canLoadMore;

  CharactersLoaded({required this.characters, required this.canLoadMore});
}

class CharactersFailure extends CharactersState {
  final Object error;

  CharactersFailure({required this.error});
}
