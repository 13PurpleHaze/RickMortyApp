abstract class Event {
  final String name;
  final Map<String, Object>? params;

  Event({required this.name, required this.params});
}
