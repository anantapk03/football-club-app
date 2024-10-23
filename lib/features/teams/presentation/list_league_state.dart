import '../model/league_item_model.dart';

abstract class ListLeagueState {}

class LisLeagueLoadSuccess extends ListLeagueState {
  final List<LeagueItemModel> listLeague;

  LisLeagueLoadSuccess(this.listLeague);
}

class ListLeagueLoading extends ListLeagueState {}

class ListLeagueIdle extends ListLeagueState {}

class ListLeagueError extends ListLeagueState {}
