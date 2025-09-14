import 'package:flutter/material.dart';

const primaryColor = Color(0xFF5757AC);

final lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: primaryColor,
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: primaryColor,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: primaryColor,
  ),
);
