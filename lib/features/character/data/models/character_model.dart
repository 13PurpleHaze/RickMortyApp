import 'package:json_annotation/json_annotation.dart';

import 'package:rick_morty_app/features/character/data/models/models.dart';
import 'package:rick_morty_app/features/character/domain/entities/entities.dart';

part 'character_model.g.dart';

@JsonSerializable()
class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final NameLinkModel origin;
  final NameLinkModel location;
  final String image;
  final List<String> episode;

  CharacterModel({
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

  factory CharacterModel.fromJson(Map<String, dynamic> json) =>
      _$CharacterModelFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterModelToJson(this);

  CharacterStatus get _status {
    return switch (status) {
      'Alive' => CharacterStatus.alive,
      'Dead' => CharacterStatus.dead,
      _ => CharacterStatus.unknown,
    };
  }

  CharacterGender get _gender {
    return switch (gender) {
      'Male' => CharacterGender.male,
      'Female' => CharacterGender.female,
      'Genderless' => CharacterGender.genderless,
      _ => CharacterGender.unknown,
    };
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: _status,
      species: species,
      gender: _gender,
      origin: origin as NameLink,
      location: location as NameLink,
      image: image,
      episode: episode,
    );
  }
}
