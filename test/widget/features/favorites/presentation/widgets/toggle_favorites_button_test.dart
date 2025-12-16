import 'package:mockito/mockito.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';
import 'package:rick_morty_app/features/favorites/presentation/widgets/widgets.dart';

import '../../../../../fixtures/character_fixture.dart';
import '../../../../core/mocks/mocks.mocks.dart';

void main() {
  late MockFavoritesBloc mockFavoritesBloc;
  late ToggleFavoritesButton toggleFavoritesButton;
  late Character character;

  setUp(() {
    mockFavoritesBloc = MockFavoritesBloc();
    character = CharacterFixture.single();
    toggleFavoritesButton = ToggleFavoritesButton(character: character);
  });

  testWidgets('should show favorite_border icon when is not favorite', (
    widgetTester,
  ) async {
    when(
      mockFavoritesBloc.state,
    ).thenReturn(FavoritesLoaded(favoriteIds: [], favorites: []));
    when(
      mockFavoritesBloc.stream,
    ).thenAnswer((_) => Stream.value(mockFavoritesBloc.state));

    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FavoritesBloc>.value(
          value: mockFavoritesBloc,
          child: ToggleFavoritesButton(character: character),
        ),
      ),
    );

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsNothing);
  });

  testWidgets('should show favorite icon when is favorite', (
    widgetTester,
  ) async {
    final favorites = CharacterFixture.list(count: 2);
    when(
      mockFavoritesBloc.state,
    ).thenReturn(FavoritesLoaded(favoriteIds: [1, 2], favorites: favorites));
    when(
      mockFavoritesBloc.stream,
    ).thenAnswer((_) => Stream.value(mockFavoritesBloc.state));

    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FavoritesBloc>.value(
          value: mockFavoritesBloc,
          child: ToggleFavoritesButton(character: character),
        ),
      ),
    );

    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsNothing);
  });

  testWidgets('should dispatch ToggleFavorite when toggled', (
    widgetTester,
  ) async {
    when(
      mockFavoritesBloc.state,
    ).thenReturn(FavoritesLoaded(favoriteIds: [], favorites: []));
    when(
      mockFavoritesBloc.stream,
    ).thenAnswer((_) => Stream.value(mockFavoritesBloc.state));

    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FavoritesBloc>.value(
          value: mockFavoritesBloc,
          child: ToggleFavoritesButton(character: character),
        ),
      ),
    );

    await widgetTester.tap(find.byType(IconButton));
    await widgetTester.pump();

    verify(
      mockFavoritesBloc.add(
        argThat(
          predicate((e) => e is ToggleFavorite && e.character == character),
        ),
      ),
    ).called(1);
  });

  testWidgets('should not rebuild when FavoriteToggledFailure', (
    widgetTester,
  ) async {
    when(
      mockFavoritesBloc.state,
    ).thenReturn(FavoritesLoaded(favoriteIds: [], favorites: []));
    when(mockFavoritesBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([
        FavoritesLoaded(favoriteIds: [], favorites: []),
        FavoriteToggledFailure(error: Object()),
      ]),
    );

    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<FavoritesBloc>.value(
          value: mockFavoritesBloc,
          child: ToggleFavoritesButton(character: character),
        ),
      ),
    );

    final iconBefore = find.byIcon(Icons.favorite_border);

    await widgetTester.pump();

    expect(iconBefore, findsOneWidget);
  });
}
