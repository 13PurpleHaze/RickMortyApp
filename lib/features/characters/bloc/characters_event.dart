part of 'characters_bloc.dart';

class CharactersEvent {}

class LoadCharacters extends CharactersEvent {}

class LoadMoreCharacters extends CharactersEvent {}

class RefreshCharacters extends CharactersEvent {}

class SearchCharacters extends CharactersEvent {
  final String search;

  SearchCharacters({required this.search});
}
