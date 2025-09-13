import 'package:dio/dio.dart';
import 'package:rick_morty_app/models/models.dart';
import 'package:rick_morty_app/repositories/characters_repository/abstract_characters_repository.dart';

class CharactersRepository implements AbstractCharactersRepository {
  @override
  Future<List<Character>> loadCharacters({
    required int page,
    String? search,
  }) async {
    final Map<String, dynamic> queryParams = {'page': page, 'name': search};

    final response = await Dio().get(
      'https://rickandmortyapi.com/api/character',
      queryParameters: queryParams,
    );

    final characters =
        ListResponse.fromJson(
          response.data as Map<String, dynamic>,
          (json) => Character.fromJson(json as Map<String, dynamic>),
        ).results;

    return characters;
  }

  @override
  Future<Character> loadCharacterById({required int id}) async {
    final response = await Dio().get(
      'https://rickandmortyapi.com/api/character/$id',
    );

    final character = Character.fromJson(response.data as Map<String, dynamic>);
    return character;
  }
}
