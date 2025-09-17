import 'package:rick_morty_app/features/episodes/domain/entities/entities.dart';

abstract interface class EpisodeRepository {
  Future<List<Episode>> loadEpisodes({
    required int page,
    List<int> ids = const [],
  });
}
