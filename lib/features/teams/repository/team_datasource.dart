import '../../../components/base/base_dio_data_source.dart';
// import '../../../components/base/base_dio_datasource.dart';
import '../../../components/ext/dio_ext.dart';

class TeamDatasource extends BaseDioDataSource {
  TeamDatasource(super._client);

  Future<String> apiTeams() {
    String path = 'search_all_teams.php';
    Map<String, dynamic> queryParameters = {
      's': 'Soccer',
      'c': 'England',
    };
    return get<String>(path, queryParameters: queryParameters).load();
  }

  Future<String> apiListLeagues() {
    String path = "search_all_leagues.php";
    Map<String, dynamic> queryParameters = {
      'c': 'England',
    };

    return get<String>(path, queryParameters: queryParameters).load();
  }
}
