import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../components/config/app_route.dart';
import '../../favorite/binding/favorite_binding.dart';
import '../../favorite/presentation/favorite_screen.dart';
import '../../teams/binding/team_binding.dart';
import '../../teams/presentation/team_screen.dart';

class BottomNavigationController extends GetxController {
  // static BottomNavigationController get to => Get.find();
  var currentIndex = 0.obs;
  final pages = <String>[AppRoute.listTeam, AppRoute.favorite];

  @override
  void onInit() async {
    super.onInit();
    await _initHandleNotificationAndDeepLink();
  }

  Future<void> _initHandleNotificationAndDeepLink() async {
    var data = Get.arguments;
    if (data != null) {
      data = int.parse(data);
      if (data > 1) {
        Future.delayed(const Duration(seconds: 3)).then((onValue) =>
            Get.toNamed(AppRoute.detail, arguments: data.toString()));
      } else {
        currentIndex.value = data;
      }
    } else {
      currentIndex.value = 0;
    }
  }

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == AppRoute.listTeam) {
      return GetPageRoute(
        settings: settings,
        page: () => const TeamScreen(),
        binding: TeamBinding(),
      );
    }

    if (settings.name == AppRoute.favorite) {
      return GetPageRoute(
        settings: settings,
        page: () => const FavoriteScreen(),
        binding: FavoriteBinding(),
      );
    }

    return null;
  }
}
