import 'package:flutter/material.dart';
import 'package:rick_morty_app/router/router.dart';
import 'package:rick_morty_app/ui/theme/theme.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: 'Rick and Morty',
      theme: appTheme,
    );
  }
}
