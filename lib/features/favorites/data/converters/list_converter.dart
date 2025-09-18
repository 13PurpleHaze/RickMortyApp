import 'package:drift/drift.dart';

class ListConverter extends TypeConverter<List<String>, String> {
  const ListConverter();

  @override
  List<String> fromSql(String fromDb) {
    return fromDb.split('|').toList();
  }

  @override
  String toSql(List<String> value) {
    return value.join('|');
  }
}
