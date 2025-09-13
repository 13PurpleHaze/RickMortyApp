import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextBanner extends StatelessWidget {
  final String title;
  final String description;

  const TextBanner({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          Text(description, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
