import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_app/features/character_detail/character_detail.dart';

import '../../../../../fixtures/character_fixture.dart';
import '../../../../../fixtures/episode_fixture.dart';
import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late MockCharacterRepository mockCharacterRepository;
  late MockEpisodeRepository mockEpisodeRepository;
  late CharacterDetailBloc characterDetailBloc;

  setUp(() {
    mockCharacterRepository = MockCharacterRepository();
    mockEpisodeRepository = MockEpisodeRepository();
    characterDetailBloc = CharacterDetailBloc(
      characterRepository: mockCharacterRepository,
      episodeRepository: mockEpisodeRepository,
    );
  });

  group('_load', () {
    final character = CharacterFixture.single();
    final ids =
        character.episode.map((url) {
          return int.parse(url.split('/').last);
        }).toList();
    final episodes = EpisodeFixture.list();

    blocTest<CharacterDetailBloc, CharacterDetailState>(
      'should emits [CharacterDetailLoading, CharacterDetailLoaded] when LoadCharacterDetail succeeds',
      build: () {
        when(
          mockCharacterRepository.loadCharacterById(id: 1),
        ).thenAnswer((_) async => character);

        when(
          mockEpisodeRepository.loadEpisodes(page: 1, ids: ids),
        ).thenAnswer((_) async => episodes);
        return characterDetailBloc;
      },
      act: (bloc) => bloc.add(LoadCharacterDetail(id: 1)),
      expect:
          () => [
            isA<CharacterDetailLoading>(),
            isA<CharacterDetailLoaded>()
                .having((s) => s.character, 'character', character)
                .having((s) => s.episodes, 'episodes', episodes),
          ],
      verify: (_) {
        verify(mockCharacterRepository.loadCharacterById(id: 1)).called(1);
        verify(mockEpisodeRepository.loadEpisodes(page: 1, ids: ids)).called(1);
      },
    );
    blocTest<CharacterDetailBloc, CharacterDetailState>(
      'should emits [CharacterDetailLoading, CharacterDetailFailure] when сharacterRepository fails',
      build: () {
        when(
          mockCharacterRepository.loadCharacterById(id: 1),
        ).thenThrow(Exception('dummy error'));
        return characterDetailBloc;
      },
      act: (bloc) => bloc.add(LoadCharacterDetail(id: 1)),
      expect:
          () => [isA<CharacterDetailLoading>(), isA<CharacterDetailFailure>()],
    );

    blocTest<CharacterDetailBloc, CharacterDetailState>(
      'should emits [CharacterDetailLoading, CharacterDetailFailure] when episodesRepository fails',
      build: () {
        when(
          mockCharacterRepository.loadCharacterById(id: 1),
        ).thenAnswer((_) async => character);
        when(
          mockEpisodeRepository.loadEpisodes(page: 1, ids: ids),
        ).thenThrow(Exception('dummy error'));
        return characterDetailBloc;
      },
      act: (bloc) => bloc.add(LoadCharacterDetail(id: 1)),
      expect:
          () => [isA<CharacterDetailLoading>(), isA<CharacterDetailFailure>()],
    );
  });
}
