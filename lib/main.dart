import 'package:flutter/material.dart';
import 'package:rick_morty_app/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();
  runApp(App(preferences: preferences));
}
