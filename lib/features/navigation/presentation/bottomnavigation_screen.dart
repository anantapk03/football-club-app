import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import '../../../components/config/app_route.dart';
import 'bottomnavigation_controller.dart';

class BottomnavigationScreen extends GetView<BottomNavigationController>{

  const BottomnavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_body(),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }
  
  _body(){
    return Navigator(
      key: Get.nestedKey(1),
      onGenerateRoute: controller.onGenerateRoute,
      initialRoute: AppRoute.listTeam,
    );
  }

  _bottomNavigationBar(){
    return Obx(
      () => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          _bottomNavigationBarItem(const Icon(Icons.home), "Home"),
          _bottomNavigationBarItem(const Icon(Icons.favorite), "Favorites"),
        ],
        currentIndex: controller.currentIndex.value,
        selectedItemColor: const Color(0xff593265),
        onTap: controller.changePage,
      ),
    );
  }

  _bottomNavigationBarItem(Icon icon, String label){
    return BottomNavigationBarItem(icon: icon , label: label);
  }

  
}