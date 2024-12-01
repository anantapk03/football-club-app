import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../components/config/app_route.dart';
import '../../../components/services/database/app_database.dart';
import '../../../components/widget/app_shimmer.dart';
import '../../../components/widget/shimmer/list_club_shimmer.dart';
import 'language_setting_popup.dart';
import 'profile_controller.dart';
import 'profile_state.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async => controller.onInit(),
          child: _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (ctrl) {
      final state = ctrl.profileState.value;

      if (state is ProfileLoading) {
        return const ListClubShimmer();
      }

      if (state is ProfileError) {
        return const Center(
          child: Text("Error"),
        );
      }

      if (state is ProfileSuccess) {
        return _body(context, state.listClubSQLite);
      }

      return Container();
    });
  }

  Widget _body(BuildContext context, List<ClubTableData> clubs) {
    return ListView(
      children: [
        Stack(
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
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
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
                            Icons.logout)),
                    const SizedBox(
                      height: 16,
                    ),
                    _listFavoriteTeamBuilder(clubs, context),
                  ],
                ),
              ),
            ),
          ],
        ),
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
        padding: const EdgeInsets.all(8.0),
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
          Obx(() {
            return Text(controller.totalFavorite.value.toString());
          })
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

  Widget _itemTeam(ClubTableData? team, BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: team?.nameTeam ?? "",
              child: CachedNetworkImage(
                imageUrl: team?.badge ?? "",
                fit: BoxFit.contain,
                placeholder: (context, url) =>
                    Center(child: _buildShimmerImage()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              team?.nameTeam ?? "",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              maxLines: 1, // Ensures it only takes one line
              overflow: TextOverflow.ellipsis, // Adds "..." if overflowed
            ),
          ),
        ],
      ),
    );
  }

  _listFavoriteTeamBuilder(
      List<ClubTableData>? listClub, BuildContext context) {
    return SizedBox(
      height: 180,
      width: MediaQuery.sizeOf(context).width,
      child: CarouselView(
          onTap: (index) {
            Get.toNamed(AppRoute.detail, arguments: listClub?[index].idTeam);
          },
          itemExtent: MediaQuery.sizeOf(context).width,
          children: List.generate(listClub?.length ?? 0, (int index) {
            var dataItemClub = listClub?[index];
            return _itemTeam(dataItemClub, context);
          })),
    );
  }

  Widget _buildShimmerImage() {
    return AppShimmer(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    ));
  }
}
