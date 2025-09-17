import 'package:json_annotation/json_annotation.dart';
import 'package:rick_morty_app/features/episodes/domain/entities/entities.dart';

part 'episode_model.g.dart';

@JsonSerializable()
class EpisodeModel {
  final int id;
  final String name;
  @JsonKey(name: 'air_date')
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;

  EpisodeModel(
    this.episode, {
    required this.id,
    required this.name,
    required this.airDate,
    required this.characters,
    required this.url,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) =>
      _$EpisodeModelFromJson(json);
  Map<String, dynamic> toJson() => _$EpisodeModelToJson(this);

  Episode toEntity() {
    return Episode(
      episode,
      id: id,
      name: name,
      airDate: airDate,
      characters: characters,
      url: url,
    );
  }
}
