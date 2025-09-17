part of 'character_detail_bloc.dart';

class CharacterDetailState {}

class CharacterDetailInitial extends CharacterDetailState {}

class CharacterDetailLoading extends CharacterDetailState {}

class CharacterDetailLoaded extends CharacterDetailState {
  final Character character;
  final List<Episode> episodes;

  CharacterDetailLoaded(this.character, this.episodes);
}

class CharacterDetailFailure extends CharacterDetailState {
  final Object error;

  CharacterDetailFailure({required this.error});
}
