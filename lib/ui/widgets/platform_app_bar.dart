import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformAppBar extends StatelessWidget {
  final String title;

  const PlatformAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return SliverAppBar(title: Text(title));
    } else {
      return CupertinoSliverNavigationBar(largeTitle: Text(title));
    }
  }
}
