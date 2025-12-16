import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:rick_morty_app/features/characters/presentation/widgets/character_card.dart';

import 'package:rick_morty_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add and remove character from favorites', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    final firstCharacterCard = find.byType(CharacterCard).first;
    expect(firstCharacterCard, findsOneWidget);

    await tester.tap(firstCharacterCard);
    await tester.pumpAndSettle();

    final favoriteButton = find.byIcon(Icons.favorite_border);
    expect(favoriteButton, findsOneWidget);

    await tester.tap(favoriteButton);
    await tester.pumpAndSettle();

    final favoriteIcon = find.byIcon(Icons.favorite);
    expect(favoriteIcon, findsOneWidget);

    await tester.tap(favoriteIcon);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
