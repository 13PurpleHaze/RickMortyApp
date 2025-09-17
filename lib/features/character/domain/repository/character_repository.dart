import 'package:rick_morty_app/features/character/domain/entities/entities.dart';

abstract interface class CharacterRepository {
  Future<List<Character>> loadCharacters({required int page, String? search});
  Future<Character> loadCharacterById({required int id});
}
