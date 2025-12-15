import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rick_morty_app/core/db/database.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';
import 'package:drift/native.dart';

import '../../../../core/fixtures/character_fixture.dart';

void main() {
  late AppDatabase mockDB;
  late LocalFavoritesRepository sut;

  setUp(() {
    mockDB = AppDatabase(
      DatabaseConnection(
        NativeDatabase.memory(),
        closeStreamsSynchronously: true,
      ),
    );
    sut = LocalFavoritesRepository(database: mockDB);
  });

  tearDown(() async {
    await mockDB.close();
  });

  group('addToFavorites', () {
    test('should add character to database', () async {
      final character = CharacterFixture.single();

      await sut.addToFavorites(character);

      final favorites = await sut.loadCharacters();

      expect(favorites, hasLength(1));
      expect(favorites[0].id, character.id);
      expect(favorites[0].name, character.name);
    });

    test('should throw error on duplicate insertion', () async {
      final character = CharacterFixture.single();
      await sut.addToFavorites(character);

      expect(() => sut.addToFavorites(character), throwsA(isA<Exception>()));
    });
  });

  group('loadCharacters', () {
    test('should return empty error when has no characters in db', () async {
      final favorites = await sut.loadCharacters();

      expect(favorites, hasLength(0));
    });

    test('should return all added characters', () async {
      final characters = CharacterFixture.list(count: 2);
      await sut.addToFavorites(characters[0]);
      await sut.addToFavorites(characters[1]);

      final result = await sut.loadCharacters();

      expect(result, hasLength(2));
      expect(result.map((c) => c.id), containsAll([1, 2]));
    });

    // TODO: убрать, не важный тест какой-то
    test('should maintain insertion order', () async {
      final characters = CharacterFixture.list(count: 2);
      await sut.addToFavorites(characters[0]);
      await Future.delayed(const Duration(milliseconds: 10));
      await sut.addToFavorites(characters[1]);

      final result = await sut.loadCharacters();

      expect(result[0].id, characters[0].id);
      expect(result[1].id, characters[1].id);
    });
  });

  group('removeFromFavorites', () {
    test('should remove existing character', () async {
      final character = CharacterFixture.single();
      await sut.addToFavorites(character);

      await sut.removeFromFavorites(character.id);

      final favorites = await sut.loadCharacters();
      expect(favorites, hasLength(0));
    });

    test('should do nothing when removing non-existent character', () async {
      await sut.removeFromFavorites(999);
      final favorites = await sut.loadCharacters();
      expect(favorites, isEmpty);
    });

    test('should allow re-adding after removal', () async {
      final character = CharacterFixture.single();
      await sut.addToFavorites(character);
      await sut.removeFromFavorites(character.id);

      await sut.addToFavorites(character);

      final favorites = await sut.loadCharacters();
      expect(favorites, hasLength(1));
      expect(favorites[0].id, character.id);
    });
  });

  group('isFavorite', () {
    test('should return true for existing favorite', () async {
      final character = CharacterFixture.single();
      await sut.addToFavorites(character);

      final result = await sut.isFavorite(character.id);

      expect(result, isTrue);
    });

    test('should return false for non-existent character', () async {
      final result = await sut.isFavorite(999);

      expect(result, isFalse);
    });
    // 領域展開
    test('should return false after removal', () async {
      final character = CharacterFixture.single();
      await sut.addToFavorites(character);
      await sut.removeFromFavorites(character.id);

      final result = await sut.isFavorite(character.id);

      expect(result, isFalse);
    });
  });
}
