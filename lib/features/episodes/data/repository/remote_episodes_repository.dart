import 'package:dio/dio.dart';

import 'package:rick_morty_app/features/episodes/domain/entities/entities.dart';
import 'package:rick_morty_app/features/episodes/data/models/models.dart';
import 'package:rick_morty_app/features/episodes/domain/repository/repository.dart';

class RemoteEpisodeRepository implements EpisodeRepository {
  final Dio dio;

  RemoteEpisodeRepository({required this.dio});

  @override
  Future<List<Episode>> loadEpisodes({
    required int page,
    List<int> ids = const [],
  }) async {
    var urlString = '/episode';
    if (ids.isNotEmpty) {
      urlString += '/${ids.join(',')}';
      final response = await dio.get(urlString);
      final data = response.data as List<dynamic>;
      return data
          .map((episode) => EpisodeModel.fromJson(episode).toEntity())
          .toList();
    }

    final Map<String, dynamic> queryParams = {'page': page};
    final response = await dio.get(urlString, queryParameters: queryParams);
    final data = response.data as Map<String, dynamic>;
    final episodes =
        (data['results'] as List<dynamic>)
            .map((character) => EpisodeModel.fromJson(character).toEntity())
            .toList();
    return episodes;
  }
}
