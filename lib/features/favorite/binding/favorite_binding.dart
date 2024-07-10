import 'package:get/get.dart';
import '../../../components/util/favorite_helper.dart';
import '../presentation/favorite_controller.dart';
import '../repository/favorite_repository.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteHelper());
    Get.lazyPut(() => FavoriteRepository(Get.find()));
    Get.lazyPut(() => FavoriteController(Get.find()));
  }
}
