import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'package:rick_morty_app/features/characters/characters.dart';

import '../../../../../fixtures/character_fixture.dart';
import '../../../../core/mocks/mocks.mocks.dart';

main() {
  late CharactersBloc charactersBloc;
  late MockCharacterRepository mockCharacterRepository;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    charactersBloc = CharactersBloc(
      characterRepository: mockCharacterRepository,
    );
  });

  group('_load', () {
    final characters = CharacterFixture.list();
    blocTest<CharactersBloc, CharactersState>(
      'should emits [Loading, Loaded] when LoadCharacters succeeds',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 1),
        ).thenAnswer((_) async => characters);
        return charactersBloc;
      },
      act: (bloc) => bloc.add(LoadCharacters()),
      expect:
          () => [
            isA<CharactersLoading>(),
            isA<CharactersLoaded>()
                .having((s) => s.characters, 'characters', characters)
                .having((s) => s.canLoadMore, 'canLoadMore', true),
          ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'should emits [Loading, Failure] when LoadCharacters fails',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 1),
        ).thenThrow(Exception('dummy error'));
        return charactersBloc;
      },
      act: (bloc) => bloc.add(LoadCharacters()),
      expect: () => [isA<CharactersLoading>(), isA<CharactersFailure>()],
    );
  });

  group('_loadMore', () {
    final characters = CharacterFixture.list(count: 1);
    blocTest<CharactersBloc, CharactersState>(
      'should return nothing when state is not CharactersLoaded',
      build: () => charactersBloc,
      act: (bloc) => bloc.add(LoadMoreCharacters()),
      seed: () => CharactersLoading(),
      expect: () => [],
    );

    blocTest<CharactersBloc, CharactersState>(
      'should return nothing when cant load more',
      build: () => charactersBloc,
      act: (bloc) => bloc.add(LoadMoreCharacters()),
      seed: () => CharactersLoaded(characters: characters, canLoadMore: false),
      expect: () => [],
    );

    blocTest<CharactersBloc, CharactersState>(
      'should return [CharactersFailure] when LoadMoreCharacters fails',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 2),
        ).thenThrow(Exception('dummy error'));
        return charactersBloc;
      },
      act: (bloc) => bloc.add(LoadMoreCharacters()),
      seed: () => CharactersLoaded(characters: characters, canLoadMore: true),
      expect: () => [isA<CharactersFailure>()],
    );

    final firstPageCharacters = CharacterFixture.list(count: 20);
    final secondPageCharacters = CharacterFixture.list(count: 10);

    blocTest<CharactersBloc, CharactersState>(
      'should return [CharactersLoading, CharactersLoaded, CharactersLoaded] when LoadMoreCharacters succeeds',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 1),
        ).thenAnswer((_) async => firstPageCharacters);
        when(
          mockCharacterRepository.loadCharacters(page: 2),
        ).thenAnswer((_) async => secondPageCharacters);
        return charactersBloc;
      },
      act: (bloc) async {
        bloc.add(LoadCharacters());
        await Future.microtask(() {});
        bloc.add(LoadMoreCharacters());
      },
      expect:
          () => [
            isA<CharactersLoading>(),
            isA<CharactersLoaded>()
                .having(
                  (s) => s.characters,
                  'first page characters',
                  firstPageCharacters,
                )
                .having((s) => s.canLoadMore, 'canLoadMore', true),
            isA<CharactersLoaded>()
                .having((s) => s.characters, 'appended characters', [
                  ...firstPageCharacters,
                  ...secondPageCharacters,
                ])
                .having((s) => s.canLoadMore, 'canLoadMore', false),
          ],
    );
  });

  group('_refresh', () {
    final characters = CharacterFixture.list(count: 1);
    blocTest<CharactersBloc, CharactersState>(
      'should return [CharactersLoaded] when RefreshCharacters succeeds',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 1, search: ''),
        ).thenAnswer((_) async => characters);
        return charactersBloc;
      },
      act: (bloc) {
        final completer = Completer();
        bloc.add(RefreshCharacters(completer: completer));
      },
      expect:
          () => [
            isA<CharactersLoaded>()
                .having((s) => s.characters, 'characters', characters)
                .having((s) => s.canLoadMore, 'canLoadMore', false),
          ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'should return [CharactersFailure] when RefreshCharacters fails',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 1, search: ''),
        ).thenThrow(Exception('dummy error'));
        return charactersBloc;
      },
      act: (bloc) {
        final completer = Completer();
        bloc.add(RefreshCharacters(completer: completer));
      },
      expect: () => [isA<CharactersFailure>()],
    );

    blocTest(
      'completer is completed even on failure',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 1, search: ''),
        ).thenThrow(Exception('dummy error'));
        return charactersBloc;
      },
      act: (bloc) async {
        final completer = Completer();
        bloc.add(RefreshCharacters(completer: completer));
        await completer.future;
      },
      expect: () => [isA<CharactersFailure>()],
    );
  });

  group('__search', () {
    final characters = CharacterFixture.list(count: 1);
    blocTest<CharactersBloc, CharactersState>(
      'should return [CharactersLoading, CharactersLoaded] when SearchCharacters has empty search param',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 1),
        ).thenAnswer((_) async => characters);
        return charactersBloc;
      },
      act: (bloc) => bloc.add(SearchCharacters(search: '')),
      expect:
          () => [
            isA<CharactersLoading>(),
            isA<CharactersLoaded>()
                .having((s) => s.characters, 'characters', characters)
                .having((s) => s.canLoadMore, 'canLoadMore', false),
          ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'should return nothing when SearchCharacters has search param length less then 3',
      build: () => charactersBloc,
      act: (bloc) => bloc.add(SearchCharacters(search: 'Ri')),
      expect: () => [],
    );

    blocTest<CharactersBloc, CharactersState>(
      'should return [CharactersLoading, CharactersLoaded] when SearchCharacters succeeds',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 1, search: 'Rick'),
        ).thenAnswer((_) async => characters);
        return charactersBloc;
      },
      act: (bloc) => bloc.add(SearchCharacters(search: 'Rick')),
      expect:
          () => [
            isA<CharactersLoading>(),
            isA<CharactersLoaded>()
                .having((s) => s.characters, 'characters', characters)
                .having((s) => s.canLoadMore, 'canLoadMore', false),
          ],
    );

    blocTest<CharactersBloc, CharactersState>(
      'should return [CharactersFailure] when SearchCharacters fails',
      build: () {
        when(
          mockCharacterRepository.loadCharacters(page: 1, search: 'Rick'),
        ).thenThrow(Exception('dummy error'));
        return charactersBloc;
      },
      act: (bloc) => bloc.add(SearchCharacters(search: 'Rick')),
      expect: () => [isA<CharactersLoading>(), isA<CharactersFailure>()],
    );
  });
}
