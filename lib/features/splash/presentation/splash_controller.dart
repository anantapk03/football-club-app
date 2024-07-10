import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../../components/config/app_route.dart';

class SplashController extends GetxController {
  final _logger = Logger();
  @override
  void onInit() {
    _delay();
    super.onInit();
  }

  void _delay() {
    _logger.i("SPLASH");
    Future.delayed(const Duration(seconds: 2))
        .then((value) => Get.offNamed(AppRoute.home));
  }
}