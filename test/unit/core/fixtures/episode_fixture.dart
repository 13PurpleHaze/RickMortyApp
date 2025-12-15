import 'package:rick_morty_app/features/episodes/episodes.dart';

class EpisodeFixture {
  static List<Episode> list({int count = 20}) {
    return List.generate(
      count,
      (index) => Episode(
        'episode',
        id: index + 1,
        name: 'name',
        airDate: 'airDate',
        characters: ['characters'],
        url: 'url',
      ),
    );
  }
}
