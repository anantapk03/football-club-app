import 'package:logger/logger.dart';

import '../../../components/base/base_repository.dart';
import '../../../components/util/favorite_helper.dart';
import '../../detailclub/model/detail_club_model.dart';

class FavoriteRepository extends BaseRepository  {

  final FavoriteHelper _dataSource ;
  final _logger = Logger();
  
  FavoriteRepository(this._dataSource);

  Future<List<DetailClubModel>> getFavoriteTeams()async{
    List<DetailClubModel>favorites = await _dataSource.getFavoriteTeams();
    _logger.i("Fetched ${favorites.length} favorite teams from repository");
    return favorites;
  }

}