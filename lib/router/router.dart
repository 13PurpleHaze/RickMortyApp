import 'package:auto_route/auto_route.dart';
import 'package:rick_morty_app/features/characters/characters.dart';
import 'package:rick_morty_app/features/characters_detail/characters_detail.dart';
import 'package:rick_morty_app/features/home/home.dart';
import 'package:rick_morty_app/features/episodes/episodes.dart';
import 'package:rick_morty_app/features/settings/settings.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: [
        AutoRoute(
          page: CharactersRoute.page,
          path: 'characters',
          children: [
            AutoRoute(
              page: CharactersDetailRoute.page,
              path: 'characters-detail',
            ),
          ],
        ),
        AutoRoute(page: EpisodesRoute.page, path: 'episodes'),
        AutoRoute(page: SettingsRoute.page, path: 'settings'),
        AutoRoute(page: FavoritesRoute.page, path: 'favorites'),
      ],
    ),
  ];
}
