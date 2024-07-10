import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../components/util/favorite_helper.dart';
import '../../../components/util/helper.dart';
import '../../../components/util/state.dart';
import '../../favorite/presentation/favorite_controller.dart';
import '../model/detail_club_model.dart';
import '../repository/detailclub_repository.dart';
import 'detail_club_state.dart';

class DetailClubController extends GetxController {
  final DetailclubRepository _repository;
  DetailClubState detailClubState = DetailClubIdle();
  final FavoriteHelper _favoriteHelper;
  final _logger = Logger();
  DetailClubController(this._repository, this._favoriteHelper);

  FavoriteHelper get favoriteHelper => _favoriteHelper;

  void loadDetailClub(String idTeam) {
    detailClubState = DetailClubLoading();
    update();
    _repository.loadDetail(
        response: ResponseHandler(onSuccess: (listItem) {
      DetailClubModel? foundItem;

      for (var item in listItem) {
        if (item.idTeam == idTeam) {
          foundItem = item;
          break;
        }
      }

      if (foundItem != null) {
        detailClubState = DetailClubLoadSuccess(foundItem);
      } else {
        detailClubState = DetailClubError();
      }
    }, onFailed: (e, message) {
      _logger.e(e);
      AlertModel.showBasic("Erro", message);
    }, onDone: () {
      update();
    }));
  }

  Future<void> toggleFavorite(String idTeam) async {
    bool isFavorite = await _favoriteHelper.isFavorite(idTeam);

    if (isFavorite) {
      await _favoriteHelper.removeFavorite(idTeam);
      Get.find<FavoriteController>().loadAllClubFavorite();
      // await _favoriteHelper.getFavoriteTeams();
    } else {
      DetailClubModel? detailClub = (detailClubState is DetailClubLoadSuccess)
          ? (detailClubState as DetailClubLoadSuccess).detail
          : null;

      if (detailClub != null) {
        await _favoriteHelper.addFavorite(detailClub);
        Get.find<FavoriteController>().loadAllClubFavorite();
        await _favoriteHelper.getFavoriteTeams();
      }
    }
     // Mengupdate controller dan favorite list di FavoriteController
    update();
    Get.find<FavoriteController>().loadAllClubFavorite();
  }
}
