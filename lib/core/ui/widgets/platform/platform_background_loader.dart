import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformBackgroundLoader extends StatelessWidget {
  const PlatformBackgroundLoader({super.key});

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.android) {
      return Center(child: CircularProgressIndicator(strokeWidth: 5));
    }
    return CupertinoActivityIndicator();
  }
}
