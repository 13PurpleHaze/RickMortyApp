// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CharacterTableTable extends CharacterTable
    with TableInfo<$CharacterTableTable, CharacterTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<NameLink, String> origin =
      GeneratedColumn<String>(
        'origin',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<NameLink>($CharacterTableTable.$converterorigin);
  @override
  late final GeneratedColumnWithTypeConverter<NameLink, String> location =
      GeneratedColumn<String>(
        'location',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<NameLink>($CharacterTableTable.$converterlocation);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> episode =
      GeneratedColumn<String>(
        'episode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($CharacterTableTable.$converterepisode);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    status,
    species,
    gender,
    image,
    origin,
    location,
    episode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CharacterTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterTableData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      species:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}species'],
          )!,
      gender:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}gender'],
          )!,
      image:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}image'],
          )!,
      origin: $CharacterTableTable.$converterorigin.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}origin'],
        )!,
      ),
      location: $CharacterTableTable.$converterlocation.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}location'],
        )!,
      ),
      episode: $CharacterTableTable.$converterepisode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}episode'],
        )!,
      ),
    );
  }

  @override
  $CharacterTableTable createAlias(String alias) {
    return $CharacterTableTable(attachedDatabase, alias);
  }

  static TypeConverter<NameLink, String> $converterorigin =
      const NameLinkConverter();
  static TypeConverter<NameLink, String> $converterlocation =
      const NameLinkConverter();
  static TypeConverter<List<String>, String> $converterepisode =
      const ListConverter();
}

class CharacterTableData extends DataClass
    implements Insertable<CharacterTableData> {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;
  final NameLink origin;
  final NameLink location;
  final List<String> episode;
  const CharacterTableData({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
    required this.episode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['status'] = Variable<String>(status);
    map['species'] = Variable<String>(species);
    map['gender'] = Variable<String>(gender);
    map['image'] = Variable<String>(image);
    {
      map['origin'] = Variable<String>(
        $CharacterTableTable.$converterorigin.toSql(origin),
      );
    }
    {
      map['location'] = Variable<String>(
        $CharacterTableTable.$converterlocation.toSql(location),
      );
    }
    {
      map['episode'] = Variable<String>(
        $CharacterTableTable.$converterepisode.toSql(episode),
      );
    }
    return map;
  }

  CharacterTableCompanion toCompanion(bool nullToAbsent) {
    return CharacterTableCompanion(
      id: Value(id),
      name: Value(name),
      status: Value(status),
      species: Value(species),
      gender: Value(gender),
      image: Value(image),
      origin: Value(origin),
      location: Value(location),
      episode: Value(episode),
    );
  }

  factory CharacterTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      status: serializer.fromJson<String>(json['status']),
      species: serializer.fromJson<String>(json['species']),
      gender: serializer.fromJson<String>(json['gender']),
      image: serializer.fromJson<String>(json['image']),
      origin: serializer.fromJson<NameLink>(json['origin']),
      location: serializer.fromJson<NameLink>(json['location']),
      episode: serializer.fromJson<List<String>>(json['episode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String>(status),
      'species': serializer.toJson<String>(species),
      'gender': serializer.toJson<String>(gender),
      'image': serializer.toJson<String>(image),
      'origin': serializer.toJson<NameLink>(origin),
      'location': serializer.toJson<NameLink>(location),
      'episode': serializer.toJson<List<String>>(episode),
    };
  }

  CharacterTableData copyWith({
    int? id,
    String? name,
    String? status,
    String? species,
    String? gender,
    String? image,
    NameLink? origin,
    NameLink? location,
    List<String>? episode,
  }) => CharacterTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    status: status ?? this.status,
    species: species ?? this.species,
    gender: gender ?? this.gender,
    image: image ?? this.image,
    origin: origin ?? this.origin,
    location: location ?? this.location,
    episode: episode ?? this.episode,
  );
  CharacterTableData copyWithCompanion(CharacterTableCompanion data) {
    return CharacterTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      species: data.species.present ? data.species.value : this.species,
      gender: data.gender.present ? data.gender.value : this.gender,
      image: data.image.present ? data.image.value : this.image,
      origin: data.origin.present ? data.origin.value : this.origin,
      location: data.location.present ? data.location.value : this.location,
      episode: data.episode.present ? data.episode.value : this.episode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('gender: $gender, ')
          ..write('image: $image, ')
          ..write('origin: $origin, ')
          ..write('location: $location, ')
          ..write('episode: $episode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    status,
    species,
    gender,
    image,
    origin,
    location,
    episode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.status == this.status &&
          other.species == this.species &&
          other.gender == this.gender &&
          other.image == this.image &&
          other.origin == this.origin &&
          other.location == this.location &&
          other.episode == this.episode);
}

class CharacterTableCompanion extends UpdateCompanion<CharacterTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> status;
  final Value<String> species;
  final Value<String> gender;
  final Value<String> image;
  final Value<NameLink> origin;
  final Value<NameLink> location;
  final Value<List<String>> episode;
  const CharacterTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.species = const Value.absent(),
    this.gender = const Value.absent(),
    this.image = const Value.absent(),
    this.origin = const Value.absent(),
    this.location = const Value.absent(),
    this.episode = const Value.absent(),
  });
  CharacterTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String status,
    required String species,
    required String gender,
    required String image,
    required NameLink origin,
    required NameLink location,
    required List<String> episode,
  }) : name = Value(name),
       status = Value(status),
       species = Value(species),
       gender = Value(gender),
       image = Value(image),
       origin = Value(origin),
       location = Value(location),
       episode = Value(episode);
  static Insertable<CharacterTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? status,
    Expression<String>? species,
    Expression<String>? gender,
    Expression<String>? image,
    Expression<String>? origin,
    Expression<String>? location,
    Expression<String>? episode,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (species != null) 'species': species,
      if (gender != null) 'gender': gender,
      if (image != null) 'image': image,
      if (origin != null) 'origin': origin,
      if (location != null) 'location': location,
      if (episode != null) 'episode': episode,
    });
  }

  CharacterTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? status,
    Value<String>? species,
    Value<String>? gender,
    Value<String>? image,
    Value<NameLink>? origin,
    Value<NameLink>? location,
    Value<List<String>>? episode,
  }) {
    return CharacterTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      species: species ?? this.species,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      origin: origin ?? this.origin,
      location: location ?? this.location,
      episode: episode ?? this.episode,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(
        $CharacterTableTable.$converterorigin.toSql(origin.value),
      );
    }
    if (location.present) {
      map['location'] = Variable<String>(
        $CharacterTableTable.$converterlocation.toSql(location.value),
      );
    }
    if (episode.present) {
      map['episode'] = Variable<String>(
        $CharacterTableTable.$converterepisode.toSql(episode.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('species: $species, ')
          ..write('gender: $gender, ')
          ..write('image: $image, ')
          ..write('origin: $origin, ')
          ..write('location: $location, ')
          ..write('episode: $episode')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CharacterTableTable characterTable = $CharacterTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [characterTable];
}

typedef $$CharacterTableTableCreateCompanionBuilder =
    CharacterTableCompanion Function({
      Value<int> id,
      required String name,
      required String status,
      required String species,
      required String gender,
      required String image,
      required NameLink origin,
      required NameLink location,
      required List<String> episode,
    });
typedef $$CharacterTableTableUpdateCompanionBuilder =
    CharacterTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> status,
      Value<String> species,
      Value<String> gender,
      Value<String> image,
      Value<NameLink> origin,
      Value<NameLink> location,
      Value<List<String>> episode,
    });

class $$CharacterTableTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterTableTable> {
  $$CharacterTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<NameLink, NameLink, String> get origin =>
      $composableBuilder(
        column: $table.origin,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<NameLink, NameLink, String> get location =>
      $composableBuilder(
        column: $table.location,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get episode => $composableBuilder(
    column: $table.episode,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$CharacterTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterTableTable> {
  $$CharacterTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origin => $composableBuilder(
    column: $table.origin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get episode => $composableBuilder(
    column: $table.episode,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CharacterTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterTableTable> {
  $$CharacterTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NameLink, String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NameLink, String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get episode =>
      $composableBuilder(column: $table.episode, builder: (column) => column);
}

class $$CharacterTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterTableTable,
          CharacterTableData,
          $$CharacterTableTableFilterComposer,
          $$CharacterTableTableOrderingComposer,
          $$CharacterTableTableAnnotationComposer,
          $$CharacterTableTableCreateCompanionBuilder,
          $$CharacterTableTableUpdateCompanionBuilder,
          (
            CharacterTableData,
            BaseReferences<
              _$AppDatabase,
              $CharacterTableTable,
              CharacterTableData
            >,
          ),
          CharacterTableData,
          PrefetchHooks Function()
        > {
  $$CharacterTableTableTableManager(
    _$AppDatabase db,
    $CharacterTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CharacterTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$CharacterTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CharacterTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> species = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<NameLink> origin = const Value.absent(),
                Value<NameLink> location = const Value.absent(),
                Value<List<String>> episode = const Value.absent(),
              }) => CharacterTableCompanion(
                id: id,
                name: name,
                status: status,
                species: species,
                gender: gender,
                image: image,
                origin: origin,
                location: location,
                episode: episode,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String status,
                required String species,
                required String gender,
                required String image,
                required NameLink origin,
                required NameLink location,
                required List<String> episode,
              }) => CharacterTableCompanion.insert(
                id: id,
                name: name,
                status: status,
                species: species,
                gender: gender,
                image: image,
                origin: origin,
                location: location,
                episode: episode,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CharacterTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterTableTable,
      CharacterTableData,
      $$CharacterTableTableFilterComposer,
      $$CharacterTableTableOrderingComposer,
      $$CharacterTableTableAnnotationComposer,
      $$CharacterTableTableCreateCompanionBuilder,
      $$CharacterTableTableUpdateCompanionBuilder,
      (
        CharacterTableData,
        BaseReferences<_$AppDatabase, $CharacterTableTable, CharacterTableData>,
      ),
      CharacterTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CharacterTableTableTableManager get characterTable =>
      $$CharacterTableTableTableManager(_db, _db.characterTable);
}
