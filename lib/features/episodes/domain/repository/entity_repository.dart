import '../../domain/domain.dart';

abstract interface class EpisodeRepository {
  Future<List<Episode>> loadEpisodes({
    required int page,
    List<int> ids = const [],
  });
}
