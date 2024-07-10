import 'dart:convert';
import 'package:logger/logger.dart';
import '../../../components/base/base_repository.dart';
import '../../../components/util/state.dart';
import '../model/detail_club_model.dart';
import 'detailclub_datasource.dart';

class DetailclubRepository extends BaseRepository{
  final DetailclubDatasource _datasource;
  final _logger = Logger();
  DetailclubRepository(this._datasource);

  void loadDetail({
    required ResponseHandler<List<DetailClubModel>> response,
  }) async {
    try {
      final String apiResponse = await _datasource.apiDetailClub();
      final List<dynamic> jsonList = json.decode(apiResponse)['teams'];
      List<DetailClubModel> items = jsonList.map((json)=>DetailClubModel.fromJson(json)).toList();

      response.onSuccess.call(items);
      response.onDone.call();
    
    } catch (e){
      _logger.e(e);
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }
} 