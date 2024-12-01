import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../components/util/favorite_helper.dart';
import '../../../components/util/network.dart';
import '../../../components/util/storage_util.dart';
import '../../favorite/presentation/favorite_controller.dart';
import '../../favorite/repository/favorite_repository.dart';
import '../../profile/presentation/profile_controller.dart';
import '../../teams/presentation/team_controller.dart';
import '../../teams/repository/team_datasource.dart';
import '../../teams/repository/team_repository.dart';
import '../presentation/bottom_navigation_controller.dart';

class BottomnavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteHelper());
    Get.lazyPut(() => BottomNavigationController2());
    Get.lazyPut(() => TeamDatasource(Network.dioClient()));
    Get.lazyPut(() => TeamRepository(Get.find()));
    Get.lazyPut(() => TeamController(Get.find()));
    Get.lazyPut(() => FavoriteRepository(Get.find()));
    Get.lazyPut(() => FavoriteController(Get.find()));
    Get.lazyPut(() => StorageUtil(Get.find()));
    Get.lazyPut(() => ProfileController(Get.find()));
  }
}
