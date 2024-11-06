// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClubTableTable extends ClubTable
    with TableInfo<$ClubTableTable, ClubTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClubTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _idTeamMeta = const VerificationMeta('idTeam');
  @override
  late final GeneratedColumn<String> idTeam = GeneratedColumn<String>(
      'id_team', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameTeamMeta =
      const VerificationMeta('nameTeam');
  @override
  late final GeneratedColumn<String> nameTeam = GeneratedColumn<String>(
      'name_team', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _badgeMeta = const VerificationMeta('badge');
  @override
  late final GeneratedColumn<String> badge = GeneratedColumn<String>(
      'badge', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _formedYearMeta =
      const VerificationMeta('formedYear');
  @override
  late final GeneratedColumn<String> formedYear = GeneratedColumn<String>(
      'formed_year', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _facebookUrlMeta =
      const VerificationMeta('facebookUrl');
  @override
  late final GeneratedColumn<String> facebookUrl = GeneratedColumn<String>(
      'facebook_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _twitterUrlMeta =
      const VerificationMeta('twitterUrl');
  @override
  late final GeneratedColumn<String> twitterUrl = GeneratedColumn<String>(
      'twitter_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _instagramUrlMeta =
      const VerificationMeta('instagramUrl');
  @override
  late final GeneratedColumn<String> instagramUrl = GeneratedColumn<String>(
      'instagram_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _stadionMeta =
      const VerificationMeta('stadion');
  @override
  late final GeneratedColumn<String> stadion = GeneratedColumn<String>(
      'stadion', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        idTeam,
        nameTeam,
        badge,
        formedYear,
        description,
        facebookUrl,
        twitterUrl,
        instagramUrl,
        stadion
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'club_table';
  @override
  VerificationContext validateIntegrity(Insertable<ClubTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('id_team')) {
      context.handle(_idTeamMeta,
          idTeam.isAcceptableOrUnknown(data['id_team']!, _idTeamMeta));
    } else if (isInserting) {
      context.missing(_idTeamMeta);
    }
    if (data.containsKey('name_team')) {
      context.handle(_nameTeamMeta,
          nameTeam.isAcceptableOrUnknown(data['name_team']!, _nameTeamMeta));
    } else if (isInserting) {
      context.missing(_nameTeamMeta);
    }
    if (data.containsKey('badge')) {
      context.handle(
          _badgeMeta, badge.isAcceptableOrUnknown(data['badge']!, _badgeMeta));
    } else if (isInserting) {
      context.missing(_badgeMeta);
    }
    if (data.containsKey('formed_year')) {
      context.handle(
          _formedYearMeta,
          formedYear.isAcceptableOrUnknown(
              data['formed_year']!, _formedYearMeta));
    } else if (isInserting) {
      context.missing(_formedYearMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('facebook_url')) {
      context.handle(
          _facebookUrlMeta,
          facebookUrl.isAcceptableOrUnknown(
              data['facebook_url']!, _facebookUrlMeta));
    } else if (isInserting) {
      context.missing(_facebookUrlMeta);
    }
    if (data.containsKey('twitter_url')) {
      context.handle(
          _twitterUrlMeta,
          twitterUrl.isAcceptableOrUnknown(
              data['twitter_url']!, _twitterUrlMeta));
    } else if (isInserting) {
      context.missing(_twitterUrlMeta);
    }
    if (data.containsKey('instagram_url')) {
      context.handle(
          _instagramUrlMeta,
          instagramUrl.isAcceptableOrUnknown(
              data['instagram_url']!, _instagramUrlMeta));
    } else if (isInserting) {
      context.missing(_instagramUrlMeta);
    }
    if (data.containsKey('stadion')) {
      context.handle(_stadionMeta,
          stadion.isAcceptableOrUnknown(data['stadion']!, _stadionMeta));
    } else if (isInserting) {
      context.missing(_stadionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClubTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClubTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      idTeam: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id_team'])!,
      nameTeam: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_team'])!,
      badge: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}badge'])!,
      formedYear: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}formed_year'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      facebookUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}facebook_url'])!,
      twitterUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}twitter_url'])!,
      instagramUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instagram_url'])!,
      stadion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}stadion'])!,
    );
  }

  @override
  $ClubTableTable createAlias(String alias) {
    return $ClubTableTable(attachedDatabase, alias);
  }
}

class ClubTableData extends DataClass implements Insertable<ClubTableData> {
  final int id;
  final String idTeam;
  final String nameTeam;
  final String badge;
  final String formedYear;
  final String description;
  final String facebookUrl;
  final String twitterUrl;
  final String instagramUrl;
  final String stadion;
  const ClubTableData(
      {required this.id,
      required this.idTeam,
      required this.nameTeam,
      required this.badge,
      required this.formedYear,
      required this.description,
      required this.facebookUrl,
      required this.twitterUrl,
      required this.instagramUrl,
      required this.stadion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['id_team'] = Variable<String>(idTeam);
    map['name_team'] = Variable<String>(nameTeam);
    map['badge'] = Variable<String>(badge);
    map['formed_year'] = Variable<String>(formedYear);
    map['description'] = Variable<String>(description);
    map['facebook_url'] = Variable<String>(facebookUrl);
    map['twitter_url'] = Variable<String>(twitterUrl);
    map['instagram_url'] = Variable<String>(instagramUrl);
    map['stadion'] = Variable<String>(stadion);
    return map;
  }

  ClubTableCompanion toCompanion(bool nullToAbsent) {
    return ClubTableCompanion(
      id: Value(id),
      idTeam: Value(idTeam),
      nameTeam: Value(nameTeam),
      badge: Value(badge),
      formedYear: Value(formedYear),
      description: Value(description),
      facebookUrl: Value(facebookUrl),
      twitterUrl: Value(twitterUrl),
      instagramUrl: Value(instagramUrl),
      stadion: Value(stadion),
    );
  }

  factory ClubTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClubTableData(
      id: serializer.fromJson<int>(json['id']),
      idTeam: serializer.fromJson<String>(json['idTeam']),
      nameTeam: serializer.fromJson<String>(json['nameTeam']),
      badge: serializer.fromJson<String>(json['badge']),
      formedYear: serializer.fromJson<String>(json['formedYear']),
      description: serializer.fromJson<String>(json['description']),
      facebookUrl: serializer.fromJson<String>(json['facebookUrl']),
      twitterUrl: serializer.fromJson<String>(json['twitterUrl']),
      instagramUrl: serializer.fromJson<String>(json['instagramUrl']),
      stadion: serializer.fromJson<String>(json['stadion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'idTeam': serializer.toJson<String>(idTeam),
      'nameTeam': serializer.toJson<String>(nameTeam),
      'badge': serializer.toJson<String>(badge),
      'formedYear': serializer.toJson<String>(formedYear),
      'description': serializer.toJson<String>(description),
      'facebookUrl': serializer.toJson<String>(facebookUrl),
      'twitterUrl': serializer.toJson<String>(twitterUrl),
      'instagramUrl': serializer.toJson<String>(instagramUrl),
      'stadion': serializer.toJson<String>(stadion),
    };
  }

  ClubTableData copyWith(
          {int? id,
          String? idTeam,
          String? nameTeam,
          String? badge,
          String? formedYear,
          String? description,
          String? facebookUrl,
          String? twitterUrl,
          String? instagramUrl,
          String? stadion}) =>
      ClubTableData(
        id: id ?? this.id,
        idTeam: idTeam ?? this.idTeam,
        nameTeam: nameTeam ?? this.nameTeam,
        badge: badge ?? this.badge,
        formedYear: formedYear ?? this.formedYear,
        description: description ?? this.description,
        facebookUrl: facebookUrl ?? this.facebookUrl,
        twitterUrl: twitterUrl ?? this.twitterUrl,
        instagramUrl: instagramUrl ?? this.instagramUrl,
        stadion: stadion ?? this.stadion,
      );
  ClubTableData copyWithCompanion(ClubTableCompanion data) {
    return ClubTableData(
      id: data.id.present ? data.id.value : this.id,
      idTeam: data.idTeam.present ? data.idTeam.value : this.idTeam,
      nameTeam: data.nameTeam.present ? data.nameTeam.value : this.nameTeam,
      badge: data.badge.present ? data.badge.value : this.badge,
      formedYear:
          data.formedYear.present ? data.formedYear.value : this.formedYear,
      description:
          data.description.present ? data.description.value : this.description,
      facebookUrl:
          data.facebookUrl.present ? data.facebookUrl.value : this.facebookUrl,
      twitterUrl:
          data.twitterUrl.present ? data.twitterUrl.value : this.twitterUrl,
      instagramUrl: data.instagramUrl.present
          ? data.instagramUrl.value
          : this.instagramUrl,
      stadion: data.stadion.present ? data.stadion.value : this.stadion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClubTableData(')
          ..write('id: $id, ')
          ..write('idTeam: $idTeam, ')
          ..write('nameTeam: $nameTeam, ')
          ..write('badge: $badge, ')
          ..write('formedYear: $formedYear, ')
          ..write('description: $description, ')
          ..write('facebookUrl: $facebookUrl, ')
          ..write('twitterUrl: $twitterUrl, ')
          ..write('instagramUrl: $instagramUrl, ')
          ..write('stadion: $stadion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, idTeam, nameTeam, badge, formedYear,
      description, facebookUrl, twitterUrl, instagramUrl, stadion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClubTableData &&
          other.id == this.id &&
          other.idTeam == this.idTeam &&
          other.nameTeam == this.nameTeam &&
          other.badge == this.badge &&
          other.formedYear == this.formedYear &&
          other.description == this.description &&
          other.facebookUrl == this.facebookUrl &&
          other.twitterUrl == this.twitterUrl &&
          other.instagramUrl == this.instagramUrl &&
          other.stadion == this.stadion);
}

class ClubTableCompanion extends UpdateCompanion<ClubTableData> {
  final Value<int> id;
  final Value<String> idTeam;
  final Value<String> nameTeam;
  final Value<String> badge;
  final Value<String> formedYear;
  final Value<String> description;
  final Value<String> facebookUrl;
  final Value<String> twitterUrl;
  final Value<String> instagramUrl;
  final Value<String> stadion;
  const ClubTableCompanion({
    this.id = const Value.absent(),
    this.idTeam = const Value.absent(),
    this.nameTeam = const Value.absent(),
    this.badge = const Value.absent(),
    this.formedYear = const Value.absent(),
    this.description = const Value.absent(),
    this.facebookUrl = const Value.absent(),
    this.twitterUrl = const Value.absent(),
    this.instagramUrl = const Value.absent(),
    this.stadion = const Value.absent(),
  });
  ClubTableCompanion.insert({
    this.id = const Value.absent(),
    required String idTeam,
    required String nameTeam,
    required String badge,
    required String formedYear,
    required String description,
    required String facebookUrl,
    required String twitterUrl,
    required String instagramUrl,
    required String stadion,
  })  : idTeam = Value(idTeam),
        nameTeam = Value(nameTeam),
        badge = Value(badge),
        formedYear = Value(formedYear),
        description = Value(description),
        facebookUrl = Value(facebookUrl),
        twitterUrl = Value(twitterUrl),
        instagramUrl = Value(instagramUrl),
        stadion = Value(stadion);
  static Insertable<ClubTableData> custom({
    Expression<int>? id,
    Expression<String>? idTeam,
    Expression<String>? nameTeam,
    Expression<String>? badge,
    Expression<String>? formedYear,
    Expression<String>? description,
    Expression<String>? facebookUrl,
    Expression<String>? twitterUrl,
    Expression<String>? instagramUrl,
    Expression<String>? stadion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idTeam != null) 'id_team': idTeam,
      if (nameTeam != null) 'name_team': nameTeam,
      if (badge != null) 'badge': badge,
      if (formedYear != null) 'formed_year': formedYear,
      if (description != null) 'description': description,
      if (facebookUrl != null) 'facebook_url': facebookUrl,
      if (twitterUrl != null) 'twitter_url': twitterUrl,
      if (instagramUrl != null) 'instagram_url': instagramUrl,
      if (stadion != null) 'stadion': stadion,
    });
  }

  ClubTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? idTeam,
      Value<String>? nameTeam,
      Value<String>? badge,
      Value<String>? formedYear,
      Value<String>? description,
      Value<String>? facebookUrl,
      Value<String>? twitterUrl,
      Value<String>? instagramUrl,
      Value<String>? stadion}) {
    return ClubTableCompanion(
      id: id ?? this.id,
      idTeam: idTeam ?? this.idTeam,
      nameTeam: nameTeam ?? this.nameTeam,
      badge: badge ?? this.badge,
      formedYear: formedYear ?? this.formedYear,
      description: description ?? this.description,
      facebookUrl: facebookUrl ?? this.facebookUrl,
      twitterUrl: twitterUrl ?? this.twitterUrl,
      instagramUrl: instagramUrl ?? this.instagramUrl,
      stadion: stadion ?? this.stadion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (idTeam.present) {
      map['id_team'] = Variable<String>(idTeam.value);
    }
    if (nameTeam.present) {
      map['name_team'] = Variable<String>(nameTeam.value);
    }
    if (badge.present) {
      map['badge'] = Variable<String>(badge.value);
    }
    if (formedYear.present) {
      map['formed_year'] = Variable<String>(formedYear.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (facebookUrl.present) {
      map['facebook_url'] = Variable<String>(facebookUrl.value);
    }
    if (twitterUrl.present) {
      map['twitter_url'] = Variable<String>(twitterUrl.value);
    }
    if (instagramUrl.present) {
      map['instagram_url'] = Variable<String>(instagramUrl.value);
    }
    if (stadion.present) {
      map['stadion'] = Variable<String>(stadion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClubTableCompanion(')
          ..write('id: $id, ')
          ..write('idTeam: $idTeam, ')
          ..write('nameTeam: $nameTeam, ')
          ..write('badge: $badge, ')
          ..write('formedYear: $formedYear, ')
          ..write('description: $description, ')
          ..write('facebookUrl: $facebookUrl, ')
          ..write('twitterUrl: $twitterUrl, ')
          ..write('instagramUrl: $instagramUrl, ')
          ..write('stadion: $stadion')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClubTableTable clubTable = $ClubTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [clubTable];
}

typedef $$ClubTableTableCreateCompanionBuilder = ClubTableCompanion Function({
  Value<int> id,
  required String idTeam,
  required String nameTeam,
  required String badge,
  required String formedYear,
  required String description,
  required String facebookUrl,
  required String twitterUrl,
  required String instagramUrl,
  required String stadion,
});
typedef $$ClubTableTableUpdateCompanionBuilder = ClubTableCompanion Function({
  Value<int> id,
  Value<String> idTeam,
  Value<String> nameTeam,
  Value<String> badge,
  Value<String> formedYear,
  Value<String> description,
  Value<String> facebookUrl,
  Value<String> twitterUrl,
  Value<String> instagramUrl,
  Value<String> stadion,
});

class $$ClubTableTableFilterComposer
    extends Composer<_$AppDatabase, $ClubTableTable> {
  $$ClubTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get idTeam => $composableBuilder(
      column: $table.idTeam, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameTeam => $composableBuilder(
      column: $table.nameTeam, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get badge => $composableBuilder(
      column: $table.badge, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get formedYear => $composableBuilder(
      column: $table.formedYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get facebookUrl => $composableBuilder(
      column: $table.facebookUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get twitterUrl => $composableBuilder(
      column: $table.twitterUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instagramUrl => $composableBuilder(
      column: $table.instagramUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stadion => $composableBuilder(
      column: $table.stadion, builder: (column) => ColumnFilters(column));
}

class $$ClubTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ClubTableTable> {
  $$ClubTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get idTeam => $composableBuilder(
      column: $table.idTeam, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameTeam => $composableBuilder(
      column: $table.nameTeam, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get badge => $composableBuilder(
      column: $table.badge, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get formedYear => $composableBuilder(
      column: $table.formedYear, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get facebookUrl => $composableBuilder(
      column: $table.facebookUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get twitterUrl => $composableBuilder(
      column: $table.twitterUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instagramUrl => $composableBuilder(
      column: $table.instagramUrl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stadion => $composableBuilder(
      column: $table.stadion, builder: (column) => ColumnOrderings(column));
}

class $$ClubTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClubTableTable> {
  $$ClubTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idTeam =>
      $composableBuilder(column: $table.idTeam, builder: (column) => column);

  GeneratedColumn<String> get nameTeam =>
      $composableBuilder(column: $table.nameTeam, builder: (column) => column);

  GeneratedColumn<String> get badge =>
      $composableBuilder(column: $table.badge, builder: (column) => column);

  GeneratedColumn<String> get formedYear => $composableBuilder(
      column: $table.formedYear, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get facebookUrl => $composableBuilder(
      column: $table.facebookUrl, builder: (column) => column);

  GeneratedColumn<String> get twitterUrl => $composableBuilder(
      column: $table.twitterUrl, builder: (column) => column);

  GeneratedColumn<String> get instagramUrl => $composableBuilder(
      column: $table.instagramUrl, builder: (column) => column);

  GeneratedColumn<String> get stadion =>
      $composableBuilder(column: $table.stadion, builder: (column) => column);
}

class $$ClubTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClubTableTable,
    ClubTableData,
    $$ClubTableTableFilterComposer,
    $$ClubTableTableOrderingComposer,
    $$ClubTableTableAnnotationComposer,
    $$ClubTableTableCreateCompanionBuilder,
    $$ClubTableTableUpdateCompanionBuilder,
    (
      ClubTableData,
      BaseReferences<_$AppDatabase, $ClubTableTable, ClubTableData>
    ),
    ClubTableData,
    PrefetchHooks Function()> {
  $$ClubTableTableTableManager(_$AppDatabase db, $ClubTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClubTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClubTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClubTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> idTeam = const Value.absent(),
            Value<String> nameTeam = const Value.absent(),
            Value<String> badge = const Value.absent(),
            Value<String> formedYear = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> facebookUrl = const Value.absent(),
            Value<String> twitterUrl = const Value.absent(),
            Value<String> instagramUrl = const Value.absent(),
            Value<String> stadion = const Value.absent(),
          }) =>
              ClubTableCompanion(
            id: id,
            idTeam: idTeam,
            nameTeam: nameTeam,
            badge: badge,
            formedYear: formedYear,
            description: description,
            facebookUrl: facebookUrl,
            twitterUrl: twitterUrl,
            instagramUrl: instagramUrl,
            stadion: stadion,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String idTeam,
            required String nameTeam,
            required String badge,
            required String formedYear,
            required String description,
            required String facebookUrl,
            required String twitterUrl,
            required String instagramUrl,
            required String stadion,
          }) =>
              ClubTableCompanion.insert(
            id: id,
            idTeam: idTeam,
            nameTeam: nameTeam,
            badge: badge,
            formedYear: formedYear,
            description: description,
            facebookUrl: facebookUrl,
            twitterUrl: twitterUrl,
            instagramUrl: instagramUrl,
            stadion: stadion,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClubTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClubTableTable,
    ClubTableData,
    $$ClubTableTableFilterComposer,
    $$ClubTableTableOrderingComposer,
    $$ClubTableTableAnnotationComposer,
    $$ClubTableTableCreateCompanionBuilder,
    $$ClubTableTableUpdateCompanionBuilder,
    (
      ClubTableData,
      BaseReferences<_$AppDatabase, $ClubTableTable, ClubTableData>
    ),
    ClubTableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClubTableTableTableManager get clubTable =>
      $$ClubTableTableTableManager(_db, _db.clubTable);
}
