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

  void changePage(int index){
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings){
    
    if(settings.name == AppRoute.listTeam){
      return GetPageRoute(
        settings: settings,
        page: () => const TeamScreen(),
        binding: TeamBinding(),
      );
    }

    if(settings.name == AppRoute.favorite){
      return GetPageRoute(
        settings: settings,
        page: () => const FavoriteScreen(),
        binding: FavoriteBinding(),
      );
    }

    return null;

  }

}