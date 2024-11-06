import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../config/app_const.dart';
import 'table/club_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [ClubTable])
class AppDatabase extends _$AppDatabase {
  // Private constructor for singleton
  AppDatabase._internal() : super(_openConnection());

  // Singleton instance
  static final AppDatabase _instance = AppDatabase._internal();

  // Factory constructor to return the singleton instance
  factory AppDatabase() => _instance;

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: AppConst.databaseName);
  }
}
