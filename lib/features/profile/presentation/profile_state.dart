import '../../../components/services/database/app_database.dart';

abstract class ProfileState {}

class ProfileSuccess extends ProfileState {
  final List<ClubTableData> listClubSQLite;

  ProfileSuccess(this.listClubSQLite);
}

class ProfileLoading extends ProfileState {}

class ProfileIdle extends ProfileState {}

class ProfileError extends ProfileState {}
