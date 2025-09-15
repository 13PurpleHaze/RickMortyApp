import 'package:flutter/material.dart';
import 'package:rick_morty_app/app/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  final preferences = await SharedPreferences.getInstance();

  runApp(App(preferences: preferences));
}
