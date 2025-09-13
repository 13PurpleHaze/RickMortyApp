part of 'character_detail_bloc.dart';

class CharacterDetailEvent {}

class LoadCharacterDetail extends CharacterDetailEvent {
  final int id;

  LoadCharacterDetail({required this.id});
}
