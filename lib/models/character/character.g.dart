// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  status: $enumDecode(_$CharacterStatusEnumMap, json['status']),
  species: json['species'] as String,
  gender: $enumDecode(_$CharacterGenderEnumMap, json['gender']),
  origin: NameLink.fromJson(json['origin'] as Map<String, dynamic>),
  location: NameLink.fromJson(json['location'] as Map<String, dynamic>),
  image: json['image'] as String,
  episode: (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'status': _$CharacterStatusEnumMap[instance.status]!,
  'species': instance.species,
  'gender': _$CharacterGenderEnumMap[instance.gender]!,
  'origin': instance.origin,
  'location': instance.location,
  'image': instance.image,
  'episode': instance.episode,
};

const _$CharacterStatusEnumMap = {
  CharacterStatus.alive: 'Alive',
  CharacterStatus.dead: 'Dead',
  CharacterStatus.unknown: 'unknown',
};

const _$CharacterGenderEnumMap = {
  CharacterGender.female: 'Female',
  CharacterGender.male: 'Male',
  CharacterGender.genderless: 'Genderless',
  CharacterGender.unknown: 'unknown',
};
