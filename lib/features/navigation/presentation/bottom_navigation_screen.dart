import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../components/widget/item_bottom_app_bar_widget.dart';
import 'bottom_navigation_controller.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final controller = BottomNavigationController2();
  StreamSubscription? disposeRefresh;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    disposeRefresh?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final content = Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Obx(() {
        return SafeArea(
            child: IndexedStack(
          index: controller.selectedItem.value,
          children: controller.widgetList,
        ));
      }),
      bottomNavigationBar: Obx(() {
        return Container(
            padding: const EdgeInsets.all(8.0),
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
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
                  ItemBottomAppBarWidget(
                    label: AppLocalizations.of(context)?.home,
                    icon: Icons.home,
                    selectedItem: 0,
                    value: controller.selectedItem.value,
                    onTap: () {
                      controller.onItemTapped(0);
                    },
                  ),
                  ItemBottomAppBarWidget(
                    label: AppLocalizations.of(context)?.favorite,
                    icon: Icons.favorite,
                    selectedItem: 1,
                    value: controller.selectedItem.value,
                    onTap: () {
                      controller.onItemTapped(1);
                    },
                  ),
                  ItemBottomAppBarWidget(
                    label: AppLocalizations.of(context)?.profile,
                    icon: Icons.account_circle_outlined,
                    selectedItem: 2,
                    value: controller.selectedItem.value,
                    onTap: () {
                      controller.onItemTapped(2);
                    },
                  )
                ],
              ),
            ));
      }),
    );
    return BottomNavigationScreenData(
        bottomNavigationController2: controller, child: content);
  }
}

class BottomNavigationScreenData extends InheritedWidget {
  final BottomNavigationController2 bottomNavigationController2;
  const BottomNavigationScreenData(
      {super.key,
      required super.child,
      required this.bottomNavigationController2});

  static BottomNavigationScreenData? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BottomNavigationScreenData>();
  }

  @override
  bool updateShouldNotify(covariant BottomNavigationScreenData oldWidget) {
    // TODO: implement updateShouldNotify
    return bottomNavigationController2 != oldWidget.bottomNavigationController2;
  }
}
