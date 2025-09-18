import 'package:rick_morty_app/features/character/character.dart';

abstract interface class FavoriteRepository {
  Future<List<Character>> loadCharacters();
  addToFavorites(Character character);
  removeFromFavorites(int id);
  Future<bool> isFavorite(int id);
}
