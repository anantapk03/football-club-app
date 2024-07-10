import '../../detailclub/model/detail_club_model.dart';

abstract class FavoriteState{}

class FavoriteLoadSuccess extends FavoriteState{
  final List<DetailClubModel> listClub;

  FavoriteLoadSuccess(this.listClub);
}

class FavoriteLoading extends FavoriteState{}
class FavoriteIdle extends FavoriteState{}
class FavoriteError extends FavoriteState{}


