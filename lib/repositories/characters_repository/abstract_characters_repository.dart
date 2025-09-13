import 'package:rick_morty_app/models/models.dart';

abstract class AbstractCharactersRepository {
  Future<List<Character>> loadCharacters({required int page, String? search});
}
