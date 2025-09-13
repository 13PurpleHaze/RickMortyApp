import 'package:json_annotation/json_annotation.dart';
import 'package:rick_morty_app/models/character_gender/character_gender.dart';
import 'package:rick_morty_app/models/character_status/character_status.dart';
import 'package:rick_morty_app/models/name_link/name_link.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final CharacterStatus status;
  final String species;
  final CharacterGender gender;
  final NameLink origin;
  final NameLink location;
  final String image;
  final List<String> episode;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
  });

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterToJson(this);
}
