import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

import '../../../../core/fixtures/character_fixture.dart';
import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late MockFavoriteRepository mockFavoriteRepository;
  late FavoritesBloc favoritesBloc;

  setUp(() {
    mockFavoriteRepository = MockFavoriteRepository();
    favoritesBloc = FavoritesBloc(favoriteRepository: mockFavoriteRepository);
  });

  group('_load', () {
    final characters = CharacterFixture.list(count: 10);
    final charactersIds = characters.map((character) => character.id).toList();
    blocTest<FavoritesBloc, FavoritesState>(
      'should emits [FavoritesLoading, FavoritesLoaded] when LoadFavorites succeeds',
      build: () {
        when(
          mockFavoriteRepository.loadCharacters(),
        ).thenAnswer((_) async => characters);
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(LoadFavorites()),
      expect:
          () => [
            isA<FavoritesLoading>(),
            isA<FavoritesLoaded>()
                .having((s) => s.favorites, 'favorites', characters)
                .having((s) => s.favoriteIds, 'favoriteIds', charactersIds),
          ],
    );
    blocTest<FavoritesBloc, FavoritesState>(
      'should emits [FavoritesLoading, FavoritesFailure] when LoadFavorites fails',
      build: () {
        when(
          mockFavoriteRepository.loadCharacters(),
        ).thenThrow(Exception('dummy error'));
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(LoadFavorites()),
      expect: () => [isA<FavoritesLoading>(), isA<FavoritesFailure>()],
    );
  });

  group('_toggle', () {
    final characters = CharacterFixture.list(count: 10);
    final charactersIds = characters.map((character) => character.id).toList();
    blocTest<FavoritesBloc, FavoritesState>(
      'should return nothing when state is not FavoritesLoaded',
      build: () => favoritesBloc,
      act: (bloc) => bloc.add(ToggleFavorite(character: characters[0])),
      seed: () => FavoritesLoading(),
      expect: () => [],
      verify: (_) {
        verifyNever(mockFavoriteRepository.addToFavorites(any));
        verifyNever(mockFavoriteRepository.removeFromFavorites(any));
      },
    );
    blocTest<FavoritesBloc, FavoritesState>(
      'should call removeFromFavorites when isFavorite is true',
      build: () {
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(ToggleFavorite(character: characters[0])),
      seed:
          () => FavoritesLoaded(
            favorites: characters,
            favoriteIds: charactersIds,
          ),
      verify:
          (_) =>
              verify(mockFavoriteRepository.removeFromFavorites(1)).called(1),
    );
    blocTest<FavoritesBloc, FavoritesState>(
      'should call addToFavorites when isFavorite is false',
      build: () {
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(ToggleFavorite(character: characters[0])),
      seed:
          () => FavoritesLoaded(
            favorites:
                characters.where((character) => character.id != 1).toList(),
            favoriteIds: charactersIds.where((id) => id != 1).toList(),
          ),
      verify:
          (_) => verify(
            mockFavoriteRepository.addToFavorites(characters[0]),
          ).called(1),
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'should emit [FavoritesLoaded] when ToggleFavorite succeeds',
      build: () {
        when(
          mockFavoriteRepository.removeFromFavorites(1),
        ).thenAnswer((_) async {});
        when(mockFavoriteRepository.loadCharacters()).thenAnswer(
          (_) async =>
              characters.where((character) => character.id != 1).toList(),
        );
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(ToggleFavorite(character: characters[0])),
      seed:
          () => FavoritesLoaded(
            favoriteIds: charactersIds,
            favorites: characters,
          ),
      expect:
          () => [
            isA<FavoritesLoaded>().having(
              (s) => s.favoriteIds,
              'favoriteIds',
              charactersIds.where((id) => id != 1).toList(),
            ),
          ],
      verify: (_) {
        verify(mockFavoriteRepository.removeFromFavorites(1)).called(1);
        verify(mockFavoriteRepository.loadCharacters()).called(1);
      },
    );

    blocTest<FavoritesBloc, FavoritesState>(
      'should emit [FavoriteToggledFailure] when ToggleFavorite fails',
      build: () {
        when(
          mockFavoriteRepository.loadCharacters(),
        ).thenAnswer((_) async => characters);
        when(
          mockFavoriteRepository.removeFromFavorites(1),
        ).thenThrow(Exception('Delete failed'));
        return favoritesBloc;
      },
      act: (bloc) => bloc.add(ToggleFavorite(character: characters[0])),
      seed:
          () => FavoritesLoaded(
            favorites: characters,
            favoriteIds: charactersIds,
          ),
      expect: () => [isA<FavoriteToggledFailure>()],
      verify: (_) {
        verify(mockFavoriteRepository.removeFromFavorites(1)).called(1);
        verifyNever(mockFavoriteRepository.loadCharacters());
      },
    );
  });
}
