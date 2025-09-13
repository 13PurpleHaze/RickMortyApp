import 'package:json_annotation/json_annotation.dart';

enum CharacterGender {
  @JsonValue("Female")
  female,
  @JsonValue("Male")
  male,
  @JsonValue("Genderless")
  genderless,
  unknown,
}
