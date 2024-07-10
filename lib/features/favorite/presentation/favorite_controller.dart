import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../components/util/helper.dart';
import '../../detailclub/model/detail_club_model.dart';
import '../repository/favorite_repository.dart';
import 'favorite_state.dart';

class FavoriteController extends GetxController {
  final FavoriteRepository _repository;
  // var favoriteState = FavoriteIdle().obs;
  var favoriteState = Rx<FavoriteState>(FavoriteIdle());
  final _logger = Logger();
  RxList<DetailClubModel> favoriteTeams = <DetailClubModel>[].obs;
  FavoriteController(this._repository);

  @override
  void onInit() {
    loadAllClubFavorite();
    super.onInit();
  }

  void loadAllClubFavorite() async {
    favoriteState.value = FavoriteLoading();
    update();
    try{
      List<DetailClubModel> favorites = await _repository.getFavoriteTeams();
      favoriteState.value = FavoriteLoadSuccess(favorites);
    } catch(e){
      _logger.e(e);
      AlertModel.showBasic("Error", e.toString());
      favoriteState.value = FavoriteError();
    } finally {
      update();
    }
  }
}
