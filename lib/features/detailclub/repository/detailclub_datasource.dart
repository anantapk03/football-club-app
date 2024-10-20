import '../../../components/base/base_dio_data_source.dart';
import '../../../components/ext/dio_ext.dart';

class DetailclubDatasource extends BaseDioDataSource {
  DetailclubDatasource(super._client);

  Future<String> apiDetailClub() {
    String path = 'search_all_teams.php';
    Map<String, dynamic> queryParameters = {
      's': 'Soccer',
      'c': 'Indonesia',
    };
    return get<String>(path, queryParameters: queryParameters).load();
  }

  Future<String> getHistoryEventById(String idTeam) {
    String path = 'eventslast.php';

    Map<String, dynamic> queryParameters = {'id': idTeam};

    return get<String>(path, queryParameters: queryParameters).load();
  }
}
