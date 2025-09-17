import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformBackgroundLoader extends StatelessWidget {
  const PlatformBackgroundLoader({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Center(child: CircularProgressIndicator(strokeWidth: 5));
    }
    return CupertinoActivityIndicator();
  }
}
