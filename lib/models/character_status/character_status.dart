import 'package:json_annotation/json_annotation.dart';

enum CharacterStatus {
  @JsonValue("Alive")
  alive,
  @JsonValue("Dead")
  dead,
  unknown,
}
