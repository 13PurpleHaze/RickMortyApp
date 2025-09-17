class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;

  Episode(
    this.episode, {
    required this.id,
    required this.name,
    required this.airDate,
    required this.characters,
    required this.url,
  });
}
