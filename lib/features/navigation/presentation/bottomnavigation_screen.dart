// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottomnavigation_controller.dart';

class BottomnavigationScreen extends GetView<BottomNavigationController> {
  const BottomnavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.currentIndex.value != 0) {
          controller.changePage(0);
          return false; // Jangan keluar dari aplikasi
        }
        return true; // Keluar dari aplikasi jika sudah di halaman home
      },
      child: Scaffold(
        body: _body(),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  _body() {
    return Navigator(
      key: Get.nestedKey(1),
      onGenerateRoute: controller.onGenerateRoute,
      initialRoute: controller.pages[controller.currentIndex.value],
    );
  }

  _bottomNavigationBar() {
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

  _bottomNavigationBarItem(Icon icon, String label) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }
}
