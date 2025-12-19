import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:rick_morty_app/core/services/firebase_analitics/event.dart';

class FirebaseAnalyticsService {
  void logEvent(Event event) async {
    FirebaseAnalytics.instance.logEvent(
      name: event.name,
      parameters: event.params,
    );
  }
}
