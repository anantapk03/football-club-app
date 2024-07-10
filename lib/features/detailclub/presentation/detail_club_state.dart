import '../model/detail_club_model.dart';

abstract class DetailClubState{}

class DetailClubLoadSuccess extends DetailClubState{
  final DetailClubModel detail;

  DetailClubLoadSuccess(this.detail);
}

class DetailClubLoading extends DetailClubState{}
class DetailClubIdle extends DetailClubState{}
class DetailClubError extends DetailClubState{}
