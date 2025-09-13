import 'package:rick_morty_app/models/models.dart';
import 'package:dio/dio.dart';

class EpisodesRepository {
  Future<List<Episode>> loadEpisodes({
    required int page,
    List<int> ids = const [],
  }) async {
    final Map<String, dynamic> queryParams = {'page': page};
    var urlString = 'https://rickandmortyapi.com/api/episode';
    if (ids.isNotEmpty) {
      urlString += '/${ids.join(',')}';
      final response = await Dio().get(urlString);
      return (response.data as List<dynamic>).map((episode) {
        return Episode.fromJson(episode);
      }).toList();
    }

    final response = await Dio().get(urlString, queryParameters: queryParams);

    final episodes =
        ListResponse.fromJson(
          response.data as Map<String, dynamic>,
          (json) => Episode.fromJson(json as Map<String, dynamic>),
        ).results;

    return episodes;
  }
}
