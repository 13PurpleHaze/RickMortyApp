import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:rick_morty_app/core/app/app.dart';
import 'package:rick_morty_app/core/db/database.dart';
import 'package:rick_morty_app/core/network/api.dart';
import 'package:rick_morty_app/firebase_options.dart';

Future<void> main() async {
  await _runApp();
}

Future<void> _runApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  final preferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final config = dotenv.env;
  final baseURL = config['API_URL'] ?? 'https://rickandmortyapi.com/api';
  final apiClient = Api(baseURL);
  final appDatabase = AppDatabase();

  runApp(
    App(
      preferences: preferences,
      dio: apiClient.dio,
      config: config,
      database: appDatabase,
    ),
  );
}
