import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_morty_app/core/router/router.dart';
import 'package:rick_morty_app/core/ui/ui.dart';
import 'package:rick_morty_app/features/characters/presentation/bloc/characters_bloc.dart';
import 'package:rick_morty_app/features/characters/presentation/view/characters_screen.dart';
import 'package:rick_morty_app/features/characters/presentation/widgets/widgets.dart';

import '../../../../fixtures/character_fixture.dart';
import '../../../core/mocks/mocks.mocks.dart';

void main() {
  late CharactersScreen charactersScreen;
  late MockStackRouter mockRouter;
  late MockCharactersBloc mockCharactersBloc;

  setUp(() {
    charactersScreen = CharactersScreen();
    mockRouter = MockStackRouter();
    mockCharactersBloc = MockCharactersBloc();
  });

  testWidgets('should show loader on init', (widgetTester) async {
    when(mockCharactersBloc.state).thenReturn(CharactersLoading());
    when(
      mockCharactersBloc.stream,
    ).thenAnswer((_) => Stream.fromIterable([CharactersLoading()]));
    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CharactersBloc>.value(
          value: mockCharactersBloc,
          child: charactersScreen,
        ),
      ),
    );
    verify(mockCharactersBloc.add(argThat(isA<LoadCharacters>()))).called(1);
    expect(find.byType(PlatformBackgroundLoader), findsOneWidget);
  });

  testWidgets('should show loader, then characters when loaded', (
    widgetTester,
  ) async {
    final characters = CharacterFixture.list(count: 2);

    when(mockCharactersBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([
        CharactersLoading(),
        CharactersLoaded(characters: characters, canLoadMore: false),
      ]),
    );
    when(mockCharactersBloc.state).thenReturn(CharactersLoading());

    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CharactersBloc>.value(
          value: mockCharactersBloc,
          child: charactersScreen,
        ),
      ),
    );

    expect(find.byType(PlatformBackgroundLoader), findsOneWidget);

    await widgetTester.pump();

    expect(find.byType(CharacterCard), findsNWidgets(2));
  });

  testWidgets('should dispatch LoadMoreCharacters when scrolled near bottom', (
    widgetTester,
  ) async {
    final characters = CharacterFixture.list();
    when(
      mockCharactersBloc.state,
    ).thenReturn(CharactersLoaded(characters: characters, canLoadMore: true));

    when(
      mockCharactersBloc.stream,
    ).thenAnswer((_) => Stream.value(mockCharactersBloc.state));

    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CharactersBloc>.value(
          value: mockCharactersBloc,
          child: charactersScreen,
        ),
      ),
    );

    await widgetTester.drag(
      find.byType(CustomScrollView),
      const Offset(0, -2000),
    );
    await widgetTester.pump();

    verify(
      mockCharactersBloc.add(argThat(isA<LoadMoreCharacters>())),
    ).called(1);
  });

  testWidgets('refresh should dispatch RefreshCharacters event', (
    widgetTester,
  ) async {
    final characters = CharacterFixture.list();
    when(
      mockCharactersBloc.state,
    ).thenReturn(CharactersLoaded(characters: characters, canLoadMore: true));
    when(mockCharactersBloc.stream).thenAnswer(
      (_) => Stream.value(
        CharactersLoaded(characters: characters, canLoadMore: true),
      ),
    );

    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CharactersBloc>.value(
          value: mockCharactersBloc,
          child: const CharactersScreen(),
        ),
      ),
    );

    await widgetTester.fling(
      find.byType(RefreshIndicator),
      const Offset(0, 300),
      1000,
    );

    await widgetTester.pump();
    // TODO: почему-то без этого не работает тест
    await widgetTester.pump(Duration(seconds: 1));

    verify(mockCharactersBloc.add(argThat(isA<RefreshCharacters>()))).called(1);
  });
  testWidgets('should dispatch SearchCharacters when text changes', (
    widgetTester,
  ) async {
    final characters = CharacterFixture.list();
    when(
      mockCharactersBloc.state,
    ).thenReturn(CharactersLoaded(characters: characters, canLoadMore: true));
    when(mockCharactersBloc.stream).thenAnswer(
      (_) => Stream.value(
        CharactersLoaded(characters: characters, canLoadMore: true),
      ),
    );

    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CharactersBloc>.value(
          value: mockCharactersBloc,
          child: charactersScreen,
        ),
      ),
    );

    final textField = find.byType(TextField);
    await widgetTester.enterText(textField, 'Rick');
    await widgetTester.pump();

    verify(
      mockCharactersBloc.add(
        argThat(predicate((e) => e is SearchCharacters && e.search == 'Rick')),
      ),
    ).called(1);
  });

  testWidgets('should open CharacterDetailRoute when tap on CharacterCard', (
    WidgetTester tester,
  ) async {
    final characters = CharacterFixture.list(count: 1);
    when(
      mockCharactersBloc.state,
    ).thenReturn(CharactersLoaded(characters: characters, canLoadMore: false));
    when(
      mockCharactersBloc.stream,
    ).thenAnswer((_) => Stream.value(mockCharactersBloc.state));
    when(mockRouter.push(any)).thenAnswer((_) async => null);

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<CharactersBloc>.value(
          value: mockCharactersBloc,
          child: StackRouterScope(
            controller: mockRouter,
            stateHash: 0,
            child: charactersScreen,
          ),
        ),
      ),
    );

    await tester.tap(find.byType(CharacterCard));

    final captured = verify(mockRouter.push(captureAny)).captured;
    expect(captured.single, isA<CharacterDetailRoute>());
  });

  // TODO: добавить после того как будет баннер
  //testWidgets('should show errors banner when CharactersFailure', () async {});
}
