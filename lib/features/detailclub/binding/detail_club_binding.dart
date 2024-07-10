import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import '../../../components/util/favorite_helper.dart';
import '../../../components/util/network.dart';
import '../../favorite/presentation/favorite_controller.dart';
import '../../favorite/repository/favorite_repository.dart';
import '../presentation/detail_club_controller.dart';
import '../repository/detailclub_datasource.dart';
import '../repository/detailclub_repository.dart';

class DetailClubBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>DetailclubDatasource(Network.dioClient()));
    Get.lazyPut(()=>DetailclubRepository(Get.find()));
    Get.lazyPut(()=>FavoriteHelper());
    Get.lazyPut(()=>DetailClubController(Get.find(), Get.find()));
    Get.lazyPut(()=>FavoriteRepository(Get.find()));
    Get.lazyPut(()=>FavoriteController(Get.find()));
  }
}