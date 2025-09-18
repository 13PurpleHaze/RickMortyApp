import '../../domain/domain.dart';

abstract interface class CharacterRepository {
  Future<List<Character>> loadCharacters({required int page, String? search});
  Future<Character> loadCharacterById({required int id});
}
