// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeModel _$EpisodeModelFromJson(Map<String, dynamic> json) => EpisodeModel(
  json['episode'] as String,
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  airDate: json['air_date'] as String,
  characters:
      (json['characters'] as List<dynamic>).map((e) => e as String).toList(),
  url: json['url'] as String,
);

Map<String, dynamic> _$EpisodeModelToJson(EpisodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'characters': instance.characters,
      'url': instance.url,
    };
