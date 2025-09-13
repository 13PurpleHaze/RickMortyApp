import 'package:rick_morty_app/models/models.dart';
import 'package:dio/dio.dart';

class EpisodesRepository {
  Future<List<Episode>> loadEpisodes({required int page}) async {
    final Map<String, dynamic> queryParams = {'page': page};

    final response = await Dio().get(
      'https://rickandmortyapi.com/api/episode',
      queryParameters: queryParams,
    );

    final episodes =
        ListResponse.fromJson(
          response.data as Map<String, dynamic>,
          (json) => Episode.fromJson(json as Map<String, dynamic>),
        ).results;

    return episodes;
  }
}
