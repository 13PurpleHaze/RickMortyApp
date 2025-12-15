import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_app/features/episodes/episodes.dart';

import '../../../../core/fixtures/episode_fixture.dart';
import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late MockDio mockDio;
  late RemoteEpisodeRepository sut;

  setUp(() {
    mockDio = MockDio();
    sut = RemoteEpisodeRepository(dio: mockDio);
  });

  group('loadEpisodes', () {
    test(
      'should success call endpoint with ids when ids is not empty and succeed',
      () async {
        when(mockDio.get('/episode/1,2')).thenAnswer(
          (_) async => Response(
            data: EpisodeFixture.episodesResponseWithIds,
            statusCode: 200,
            requestOptions: RequestOptions(path: '/episode/1,2'),
          ),
        );
        final episodes = await sut.loadEpisodes(page: 1, ids: [1, 2]);
        expect(episodes, isA<List<Episode>>());
        expect(episodes.length, EpisodeFixture.episodesResponseWithIds.length);
        expect(
          episodes[0].name,
          EpisodeFixture.episodesResponseWithIds[0]['name'],
        );
        verify(mockDio.get('/episode/1,2')).called(1);
      },
    );

    test(
      'should fail call endpoint with ids when ids is not empty and fails',
      () async {
        when(mockDio.get('/episode/1,2')).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: '/episode/1,2'),
            error: 'Error',
          ),
        );

        expect(
          () => sut.loadEpisodes(ids: [1, 2], page: 1),
          throwsA(isA<DioException>()),
        );
        verify(mockDio.get('/episode/1,2')).called(1);
      },
    );

    test('should return episodes when succeed and no ids', () async {
      when(
        mockDio.get('/episode', queryParameters: anyNamed('queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: EpisodeFixture.episodesResponseWithoutIds,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/episode'),
        ),
      );
      final episodes = await sut.loadEpisodes(page: 1);
      expect(episodes, isA<List<Episode>>());
      expect(
        episodes.length,
        EpisodeFixture.episodesResponseWithoutIds['results'].length,
      );
      expect(
        episodes[0].name,
        EpisodeFixture.episodesResponseWithoutIds['results'][0]['name'],
      );
      verify(mockDio.get('/episode', queryParameters: {'page': 1})).called(1);
    });

    test('should throw when call is fail', () async {
      when(
        mockDio.get('/episode', queryParameters: anyNamed('queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/episode'),
          error: 'Error',
        ),
      );
      expect(() => sut.loadEpisodes(page: 1), throwsA(isA<DioException>()));
      verify(mockDio.get('/episode', queryParameters: {'page': 1})).called(1);
    });
  });
}
