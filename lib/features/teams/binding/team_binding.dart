import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';

import '../../../components/util/network.dart';
import '../../favorite/presentation/favorite_controller.dart';
import '../../favorite/repository/favorite_repository.dart';
import '../presentation/team_controller.dart';
import '../repository/team_datasource.dart';
import '../repository/team_repository.dart';

class TeamBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(()=>TeamDatasource(Network.dioClient()));
    Get.lazyPut(()=> TeamRepository(Get.find()));
    Get.lazyPut(()=> TeamController(Get.find()));
    Get.lazyPut(()=>FavoriteRepository(Get.find()));
    Get.lazyPut(()=>FavoriteController(Get.find()));
  }
}