import 'package:drift/drift.dart';

import 'package:rick_morty_app/features/character/character.dart';

class NameLinkConverter extends TypeConverter<NameLink, String> {
  const NameLinkConverter();

  @override
  NameLink fromSql(String fromDb) {
    final parts = fromDb.split('|');
    if (parts.length == 2) {
      return NameLink(name: parts[0], url: parts[1]);
    }
    return NameLink(name: '', url: '');
  }

  @override
  String toSql(NameLink value) {
    return '${value.name}|${value.url}';
  }
}
