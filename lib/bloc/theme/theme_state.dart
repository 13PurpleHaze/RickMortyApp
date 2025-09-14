import 'package:flutter/material.dart';

class ThemeState {
  final Brightness brightness;

  const ThemeState({required this.brightness});

  get isDart => brightness == Brightness.dark;

  ThemeState copyWith({Brightness? brightness}) {
    return ThemeState(brightness: brightness ?? this.brightness);
  }
}
