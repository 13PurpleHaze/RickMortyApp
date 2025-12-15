import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_app/features/character/character.dart';

import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late MockDio mockDio;
  late RemoteCharactersRepository sut;

  setUp(() {
    mockDio = MockDio();
    sut = RemoteCharactersRepository(dio: mockDio);
  });

  group('loadCharacterById', () {
    final mockResult = {
      'id': 1,
      'name': 'Rick Sanchez',
      'status': 'Alive',
      'species': 'Human',
      'type': '',
      'gender': 'Male',
      'origin': {
        'name': 'Earth',
        'url': 'https://rickandmortyapi.com/api/location/1',
      },
      'location': {
        'name': 'Earth',
        'url': 'https://rickandmortyapi.com/api/location/20',
      },
      'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      'episode': ['https://rickandmortyapi.com/api/episode/1'],
      'url': 'https://rickandmortyapi.com/api/character/1',
    };
    test('should return character when call is success', () async {
      when(mockDio.get('/character/1')).thenAnswer(
        (_) async => Response(
          data: mockResult,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/character/1'),
        ),
      );

      final character = await sut.loadCharacterById(id: 1);
      expect(character, isA<Character>());
      expect(character.id, 1);
      expect(character.name, 'Rick Sanchez');
      verify(mockDio.get('/character/1')).called(1);
    });

    test('should throw when call is fail', () async {
      when(mockDio.get('/character/1')).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/character/1'),
          error: 'Error',
        ),
      );
      expect(() => sut.loadCharacterById(id: 1), throwsA(isA<DioException>()));
      verify(mockDio.get('/character/1')).called(1);
    });
  });

  group('loadCharacters', () {
    final mockResult = {
      'results': [
        {
          'id': 1,
          'name': 'Rick Sanchez',
          'status': 'Alive',
          'species': 'Human',
          'type': '',
          'gender': 'Male',
          'origin': {
            'name': 'Earth',
            'url': 'https://rickandmortyapi.com/api/location/1',
          },
          'location': {
            'name': 'Earth',
            'url': 'https://rickandmortyapi.com/api/location/20',
          },
          'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
          'episode': ['https://rickandmortyapi.com/api/episode/1'],
          'url': 'https://rickandmortyapi.com/api/character/1',
          'created': '2017-11-04T18:48:46.250Z',
        },
        {
          'id': 2,
          'name': 'Morty Smith',
          'status': 'Alive',
          'species': 'Human',
          'type': '',
          'gender': 'Male',
          'origin': {
            'name': 'Earth',
            'url': 'https://rickandmortyapi.com/api/location/1',
          },
          'location': {
            'name': 'Earth',
            'url': 'https://rickandmortyapi.com/api/location/20',
          },
          'image': 'https://rickandmortyapi.com/api/character/avatar/2.jpeg',
          'episode': ['https://rickandmortyapi.com/api/episode/1'],
          'url': 'https://rickandmortyapi.com/api/character/2',
          'created': '2017-11-04T18:50:21.651Z',
        },
      ],
    };
    test('should return character list when call is success', () async {
      when(
        mockDio.get('/character', queryParameters: anyNamed('queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: mockResult,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/character'),
        ),
      );
      final characters = await sut.loadCharacters(page: 1);
      expect(characters, isA<List<Character>>());
      expect(characters.length, 2);
      expect(characters[0].name, 'Rick Sanchez');
      verify(
        mockDio.get('/character', queryParameters: {'page': 1, 'name': null}),
      ).called(1);
    });

    test('should include name param when provided', () async {
      when(
        mockDio.get('/character', queryParameters: anyNamed('queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data: mockResult,
          statusCode: 200,
          requestOptions: RequestOptions(path: '/character'),
        ),
      );
      await sut.loadCharacters(page: 1, search: 'Rick');
      verify(
        mockDio.get('/character', queryParameters: {'page': 1, 'name': 'Rick'}),
      ).called(1);
    });

    test('should throw when call is fail', () async {
      when(
        mockDio.get('/character', queryParameters: anyNamed('queryParameters')),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/character'),
          error: 'Error',
        ),
      );
      expect(() => sut.loadCharacters(page: 1), throwsA(isA<DioException>()));
      verify(
        mockDio.get('/character', queryParameters: {'page': 1, 'name': null}),
      ).called(1);
    });
  });
}
