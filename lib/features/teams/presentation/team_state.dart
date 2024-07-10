import '../model/team_model.dart';

abstract class TeamState{}
class TeamLoadSuccess extends TeamState{
  final List<TeamModel> listTeam;

  TeamLoadSuccess(this.listTeam);
}

class TeamLoading extends TeamState{}
class TeamIdle extends TeamState{}
class TeamError extends TeamState{}
