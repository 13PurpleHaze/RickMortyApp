import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_app/features/episodes/episodes.dart';

import '../../../../../fixtures/episode_fixture.dart';
import '../../../../core/mocks/mocks.mocks.dart';

main() {
  late MockEpisodeRepository mockEpisodeRepository;
  late EpisodesBloc episodesBloc;

  setUp(() {
    mockEpisodeRepository = MockEpisodeRepository();
    episodesBloc = EpisodesBloc(episodeRepository: mockEpisodeRepository);
  });

  group('_load', () {
    final episodes = EpisodeFixture.list();
    blocTest<EpisodesBloc, EpisodesState>(
      'should emits [EpisodesLoading, EpisodesLoaded] when LoadEpisodes succeeds',
      build: () {
        when(
          mockEpisodeRepository.loadEpisodes(page: 1),
        ).thenAnswer((_) async => episodes);
        return episodesBloc;
      },
      act: (bloc) => bloc.add(LoadEpisodes()),
      expect:
          () => [
            isA<EpisodesLoading>(),
            isA<EpisodesLoaded>()
                .having((s) => s.episodes, 'episodes', episodes)
                .having((s) => s.canLoadMore, 'canLoadMore', true),
          ],
    );
    blocTest<EpisodesBloc, EpisodesState>(
      'should emits [EpisodesLoading, EpisodesFailure] when LoadEpisodes fails',
      build: () {
        when(
          mockEpisodeRepository.loadEpisodes(page: 1),
        ).thenThrow(Exception('dummy error'));
        return episodesBloc;
      },
      act: (bloc) => bloc.add(LoadEpisodes()),
      expect: () => [isA<EpisodesLoading>(), isA<EpisodesFailure>()],
    );
  });

  group('_loadMore', () {
    final episodes = EpisodeFixture.list(count: 19);

    blocTest<EpisodesBloc, EpisodesState>(
      'should return nothing when state is not EpisodesLoaded',
      build: () => episodesBloc,
      act: (bloc) => bloc.add(LoadMoreEpisodes()),
      seed: () => EpisodesLoading(),
      expect: () => [],
    );
    blocTest<EpisodesBloc, EpisodesState>(
      'should return nothing when cant load more',
      build: () => episodesBloc,
      act: (bloc) => bloc.add(LoadMoreEpisodes()),
      seed: () => EpisodesLoaded(episodes: episodes, canLoadMore: false),
      expect: () => [],
    );
    blocTest<EpisodesBloc, EpisodesState>(
      'should return [EpisodesFailure] when LoadMoreEpisodes fails',
      build: () {
        when(
          mockEpisodeRepository.loadEpisodes(page: 2),
        ).thenThrow(Exception('dummy error'));
        return episodesBloc;
      },
      act: (bloc) => bloc.add(LoadMoreEpisodes()),
      seed: () => EpisodesLoaded(episodes: episodes, canLoadMore: true),
      expect: () => [isA<EpisodesFailure>()],
    );

    final firstPageEpisodes = EpisodeFixture.list();
    final secondPageEpisodes = EpisodeFixture.list(count: 19);

    blocTest<EpisodesBloc, EpisodesState>(
      'should return [EpisodesLoading, EpisodesLoaded, EpisodesLoaded] when LoadMoreEpisodes succeeds',
      build: () {
        when(
          mockEpisodeRepository.loadEpisodes(page: 1),
        ).thenAnswer((_) async => firstPageEpisodes);
        when(
          mockEpisodeRepository.loadEpisodes(page: 2),
        ).thenAnswer((_) async => secondPageEpisodes);
        return episodesBloc;
      },
      act: (bloc) async {
        bloc.add(LoadEpisodes());
        await Future.microtask(() {});
        bloc.add(LoadMoreEpisodes());
      },
      expect:
          () => [
            isA<EpisodesLoading>(),
            isA<EpisodesLoaded>()
                .having(
                  (s) => s.episodes,
                  'first page episodes',
                  firstPageEpisodes,
                )
                .having((s) => s.canLoadMore, 'canLoadMore', true),
            isA<EpisodesLoaded>()
                .having((s) => s.episodes, 'appended episodes', [
                  ...firstPageEpisodes,
                  ...secondPageEpisodes,
                ])
                .having((s) => s.canLoadMore, 'canLoadMore', false),
          ],
    );
  });

  group('_refresh', () {
    final episodes = EpisodeFixture.list();

    blocTest<EpisodesBloc, EpisodesState>(
      'should return [EpisodesLoaded] when RefreshEpisodes succeeds',
      build: () {
        when(
          mockEpisodeRepository.loadEpisodes(page: 1),
        ).thenAnswer((_) async => episodes);
        return episodesBloc;
      },
      act: (bloc) {
        final completer = Completer();
        bloc.add(RefreshEpisodes(completer: completer));
      },
      expect:
          () => [
            isA<EpisodesLoaded>()
                .having((s) => s.episodes, 'episodes', episodes)
                .having((s) => s.canLoadMore, 'canLoadMore', true),
          ],
    );
    blocTest<EpisodesBloc, EpisodesState>(
      'should return [EpisodesFailure] when RefreshEpisodes fails',
      build: () {
        when(
          mockEpisodeRepository.loadEpisodes(page: 1),
        ).thenThrow(Exception('dummy error'));
        return episodesBloc;
      },
      act: (bloc) {
        final completer = Completer();
        bloc.add(RefreshEpisodes(completer: completer));
      },
      expect: () => [isA<EpisodesFailure>()],
    );
    blocTest(
      'completer is completed even on failure',
      build: () {
        when(
          mockEpisodeRepository.loadEpisodes(page: 1),
        ).thenThrow(Exception('dummy error'));
        return episodesBloc;
      },
      act: (bloc) async {
        final completer = Completer();
        bloc.add(RefreshEpisodes(completer: completer));
        await completer.future;
      },
      expect: () => [isA<EpisodesFailure>()],
    );
  });
}
