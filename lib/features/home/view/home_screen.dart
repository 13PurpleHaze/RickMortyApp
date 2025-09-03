import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rick_morty_app/router/router.dart';
import 'package:rick_morty_app/ui/widgets/platform_navigation_bar.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [CharactersRoute(), CharactersDetailRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: PlatformNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              tabsRouter.setActiveIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                label: 'Characters',
                icon: Icon(Icons.people),
              ),
              BottomNavigationBarItem(
                label: 'Characters Detail',
                icon: Icon(Icons.abc),
              ),
            ],
          ),
        );
      },
    );
  }
}
