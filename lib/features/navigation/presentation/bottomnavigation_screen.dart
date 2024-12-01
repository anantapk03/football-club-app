// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        bottomNavigationBar: _bottomNavigationBarCustom(context),
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

  _bottomNavigationBarCustom(
    BuildContext context,
  ) {
    return Obx(() {
      return Container(
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.sizeOf(context).width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 20,
                ),
              ]),
          child: BottomAppBar(
            color: Colors.white,
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _itemBottomNavigationMenu(() {
                  controller.changePage(0);
                },
                    context,
                    AppLocalizations.of(context)?.home ?? "home",
                    _currentTextStyle(controller.currentIndex.value, 0),
                    Icons.home),
                _itemBottomNavigationMenu(() {
                  controller.changePage(1);
                },
                    context,
                    AppLocalizations.of(context)?.favorites ?? "Favorites",
                    _currentTextStyle(controller.currentIndex.value, 1),
                    Icons.favorite),
                _itemBottomNavigationMenu(() {
                  controller.changePage(2);
                },
                    context,
                    AppLocalizations.of(context)?.profile ?? "Profile",
                    _currentTextStyle(controller.currentIndex.value, 2),
                    Icons.account_circle_outlined),
              ],
            ),
          ));
    });
  }

  _itemBottomNavigationMenu(VoidCallback onTap, BuildContext context,
      String label, TextStyle style, IconData icon) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5 - 16.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(
              height: 5,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: style,
            )
          ],
        ),
      ),
    );
  }

  _currentTextStyle(int selectedItem, int value) {
    if (selectedItem == value) {
      return const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w500, color: Colors.purple);
    } else {
      return const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: 12,
      );
    }
  }
}
