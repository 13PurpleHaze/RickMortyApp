import 'package:auto_route/auto_route.dart';
import 'package:mockito/annotations.dart';
import 'package:rick_morty_app/features/characters/characters.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

@GenerateMocks([CharactersBloc, StackRouter, FavoritesBloc])
void main() {}
