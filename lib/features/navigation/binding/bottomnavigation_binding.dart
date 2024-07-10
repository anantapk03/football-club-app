import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import '../presentation/bottomnavigation_controller.dart';

class BottomnavigationBinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=>BottomNavigationController());
  }
}