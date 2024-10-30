import 'package:get/get.dart';

import '../../../components/util/storage_util.dart';
import '../presentation/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => StorageUtil(Get.find()));
    Get.lazyPut(() => ProfileController(Get.find()));
  }
}
