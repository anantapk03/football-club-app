import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../favorite/presentation/favorite_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../teams/presentation/team_screen.dart';

class BottomNavigationController2 extends GetxController {
  List<Widget> widgetList = const <Widget>[
    TeamScreen(),
    FavoriteScreen(),
    ProfileScreen()
  ];

  final selectedItem = 0.obs;

  void onItemTapped(int value) {
    selectedItem.value = value;
  }
}
