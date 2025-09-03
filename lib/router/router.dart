import 'package:auto_route/auto_route.dart';
import 'package:rick_morty_app/features/characters/characters.dart';
import 'package:rick_morty_app/features/characters_detail/characters_detail.dart';
import 'package:rick_morty_app/features/home/home.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      children: [
        AutoRoute(page: CharactersRoute.page, path: 'characters'),
        AutoRoute(page: CharactersDetailRoute.page, path: 'characters-detail'),
      ],
    ),
  ];
}
