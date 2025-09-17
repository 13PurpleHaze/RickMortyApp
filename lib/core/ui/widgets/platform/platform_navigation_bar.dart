import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformNavigationBar extends StatelessWidget {
  const PlatformNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final Function(int index) onTap;
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == 'Android') {
      return BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: onTap,
        items: items,
      );
    } else {
      return CupertinoTabBar(
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
      );
    }
  }
}
