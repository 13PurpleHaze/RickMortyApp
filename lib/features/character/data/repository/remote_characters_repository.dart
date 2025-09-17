import 'package:dio/dio.dart';
import 'package:rick_morty_app/features/character/domain/entities/entities.dart';
import 'package:rick_morty_app/features/character/domain/repository/repository.dart';
import 'package:rick_morty_app/features/character/data/models/models.dart';

class RemoteCharactersRepository implements CharacterRepository {
  final Dio dio;

  RemoteCharactersRepository({required this.dio});

  @override
  Future<Character> loadCharacterById({required int id}) async {
    final response = await dio.get('/character/$id');

    final character =
        CharacterModel.fromJson(
          response.data as Map<String, dynamic>,
        ).toEntity();
    return character;
  }

  @override
  Future<List<Character>> loadCharacters({
    required int page,
    String? search,
  }) async {
    final Map<String, dynamic> queryParams = {'page': page, 'name': search};

    final response = await dio.get('/character', queryParameters: queryParams);

    final data = response.data as Map<String, dynamic>;
    final characters =
        (data['results'] as List<dynamic>)
            .map((character) => CharacterModel.fromJson(character).toEntity())
            .toList();

    return characters;
  }
}
