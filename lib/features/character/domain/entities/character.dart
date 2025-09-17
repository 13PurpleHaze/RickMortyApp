import 'package:rick_morty_app/features/character/domain/entities/character_gender.dart';
import 'package:rick_morty_app/features/character/domain/entities/character_status.dart';
import 'package:rick_morty_app/features/character/domain/entities/name_link.dart';

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

  Map<String, String> get characteristics => {
    'Status': status.name,
    'Gender': gender.name,
    'Origin': origin.name,
    'Location': location.name,
    'Species': species,
    'Name': name,
  };
}
