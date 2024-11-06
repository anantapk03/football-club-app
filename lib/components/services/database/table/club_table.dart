import 'package:drift/drift.dart';

class ClubTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get idTeam => text().withLength(min: 6, max: 32)();
  TextColumn get nameTeam => text()();
  TextColumn get badge => text()();
  TextColumn get formedYear => text()();
  TextColumn get description => text()();
  TextColumn get facebookUrl => text()();
  TextColumn get twitterUrl => text()();
  TextColumn get instagramUrl => text()();
  TextColumn get stadion => text()();
}
