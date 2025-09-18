import 'package:drift/drift.dart';
import 'package:rick_morty_app/core/db/database.dart';

import 'package:rick_morty_app/features/character/character.dart';
import 'package:rick_morty_app/features/favorites/favorites.dart';

class CharacterTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get status => text()();
  TextColumn get species => text()();
  TextColumn get gender => text()();
  TextColumn get image => text()();
  TextColumn get origin => text().map(const NameLinkConverter())();
  TextColumn get location => text().map(const NameLinkConverter())();
  TextColumn get episode => text().map(const ListConverter())();
}

extension CharacterTableExtension on CharacterTableData {
  CharacterStatus get _status {
    return switch (status) {
      'alive' => CharacterStatus.alive,
      'dead' => CharacterStatus.dead,
      _ => CharacterStatus.unknown,
    };
  }

  CharacterGender get _gender {
    return switch (status) {
      'female' => CharacterGender.female,
      'male' => CharacterGender.male,
      'genderless' => CharacterGender.genderless,
      _ => CharacterGender.unknown,
    };
  }

  Character toEntity() {
    return Character(
      id: id,
      name: name,
      status: _status,
      species: species,
      gender: _gender,
      origin: origin,
      location: location,
      image: image,
      episode: episode,
    );
  }
}
