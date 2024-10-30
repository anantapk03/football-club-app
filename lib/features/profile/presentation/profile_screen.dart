import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import 'language_setting_popup.dart';
import 'profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: const BoxDecoration(
            color: Color(0xff5c0751),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "${AppLocalizations.of(context)?.greating ?? "Hallo"} Ananta, \n${AppLocalizations.of(context)?.welcomeText ?? "Selamat datang di Football Club"}!",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 50,
                ),
                _headerCard(context),
                const SizedBox(
                  height: 20,
                ),
                _languageSettings(context),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                    onTap: () {},
                    child: _menuItem(
                        context,
                        AppLocalizations.of(context)?.logout ?? "Logout",
                        Icons.logout))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _menuItem(BuildContext context, String title, IconData icon) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 4,
            offset: Offset(0, 2.0), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  _headerCard(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 2.0), // changes position of shadow
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(AppLocalizations.of(context)?.totalFavorite ?? "Total Favorite"),
          const SizedBox(
            height: 5,
          ),
          Text("5")
        ],
      ),
    );
  }

  _languageSettings(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              clipBehavior: Clip.antiAlias,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              builder: (ctx) {
                return FractionallySizedBox(
                  heightFactor: 0.35, // Menggunakan 90% dari tinggi layar
                  child: LanguageSettingPopup(controller: controller),
                );
              });
        },
        child: _menuItem(
            context,
            AppLocalizations.of(context)?.language ?? "Language",
            Icons.language));
  }
}
