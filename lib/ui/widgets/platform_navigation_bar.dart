import 'dart:io';

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
    if (Platform.isAndroid) {
      return BottomNavigationBar(
        currentIndex: currentIndex,
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
