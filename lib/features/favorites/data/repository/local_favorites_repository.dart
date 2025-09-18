import 'package:drift/drift.dart';
import 'package:rick_morty_app/core/db/database.dart';

import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

class LocalFavoritesRepository implements FavoriteRepository {
  final AppDatabase database;

  LocalFavoritesRepository({required this.database});

  @override
  addToFavorites(Character character) async {
    await database
        .into(database.characterTable)
        .insert(
          CharacterTableCompanion.insert(
            id: Value(character.id),
            name: character.name,
            status: character.status.name,
            species: character.species,
            gender: character.gender.name,
            image: character.image,
            origin: character.origin,
            location: character.location,
            episode: character.episode,
          ),
        );
  }

  @override
  Future<List<Character>> loadCharacters() async {
    final tables = await database.select(database.characterTable).get();
    return tables.map((table) => table.toEntity()).toList();
  }

  @override
  removeFromFavorites(int id) async {
    await (database.delete(database.characterTable)
      ..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<bool> isFavorite(int id) async {
    final query = database.select(database.characterTable)
      ..where((tbl) => tbl.id.equals(id));

    final result = await query.get();
    return result.isNotEmpty;
  }
}
