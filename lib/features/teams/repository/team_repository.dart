import 'dart:convert';

import 'package:logger/logger.dart';

import '../../../components/base/base_repository.dart';
import '../../../components/util/state.dart';
import '../model/league_item_model.dart';
import '../model/team_model.dart';
import 'team_datasource.dart';

class TeamRepository extends BaseRepository {
  final TeamDatasource _datasource;
  final _logger = Logger();
  TeamRepository(this._datasource);

  void loadTeams({required ResponseHandler<List<TeamModel>> response}) async {
    try {
      final String apiResponse = await _datasource.apiTeams();
      final List<dynamic> jsonList = json.decode(apiResponse)['teams'];
      List<TeamModel> items =
          jsonList.map((json) => TeamModel.fromJson(json)).toList();
      response.onSuccess.call(items);
      response.onDone.call();
    } catch (e) {
      _logger.e(e);
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }

  void loadListLeagues(
      {required ResponseHandler<List<LeagueItemModel>> response}) async {
    try {
      final String apiResponse = await _datasource.apiListLeagues();
      final List<dynamic> jsonList = jsonDecode(apiResponse)['countries'];
      List<LeagueItemModel> items =
          jsonList.map((json) => LeagueItemModel.fromJson(json)).toList();
      response.onSuccess.call(items);
      response.onDone.call();
    } catch (e) {
      _logger.e(e);
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }
}
