import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../components/widget/app_shimmer.dart';
import '../../../components/widget/header_detail_club_widget.dart';
import '../../../components/widget/shimmer/detail_shimmer.dart';
import '../model/detail_club_model.dart';
import 'detail_club_controller.dart';
import 'detail_club_state.dart';
import 'equipments/equipment_screen.dart';
import 'history_event/history_event_screen.dart';

class DetailClubScreen extends GetView<DetailClubController> {
  const DetailClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      floatingActionButton: _floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _body(BuildContext context) {
    return GetBuilder<DetailClubController>(
      builder: (ctrl) {
        final state = controller.detailClubState;

        if (state is DetailClubLoading) {
          return const DetailShimmer();
        }

        if (state is DetailClubLoadSuccess) {
          return _bodySliver(
            context,
            state.detail,
          );
        }

        if (state is DetailClubError) {
          return _error(context);
        }
        return Container();
      },
    );
  }

  Widget _bodySliver(BuildContext context, DetailClubModel detailClub) {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) =>
            [_sliverAppBar(context, detailClub)],
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              HistoryEventScreen(
                id: controller.id.value,
                detailClub: detailClub,
              ),
              EquipmentScreen(
                idTeam: controller.id.value,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _sliverAppBar(BuildContext context, DetailClubModel detailClub) {
    return SliverAppBar(
      expandedHeight: MediaQuery.sizeOf(context).width / 1.9,
      pinned: true,
      snap: false,
      floating: false,
      title: Text(
        detailClub.nameTeam ?? "",
        style: const TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600),
      ),
      centerTitle: true,
      flexibleSpace: FlexibleSpaceBar(
        background: HeaderDetailClubWidget(
          detailClub: detailClub,
          latitude: controller.latitude.value,
          longitude: controller.longitude.value,
        ),
      ),
      bottom: TabBar(
        labelPadding: const EdgeInsets.all(0),
        onTap: (int index) {
          controller.onItemTapped(index);
          controller.selectedItem.value = index;
        },
        indicatorColor: const Color(0xff5c0751),
        dividerColor: Colors.transparent,
        tabs: [
          Obx(() {
            return Tab(
              height: 50,
              child: _tab(
                  active: controller.selectedItem.value == 0,
                  text: AppLocalizations.of(context)?.aboutTeam ?? "About"),
            );
          }),
          Obx(() {
            return Tab(
              height: 50,
              child: _tab(
                  active: controller.selectedItem.value == 1,
                  text: AppLocalizations.of(context)?.historyJersey ??
                      "History Jersey"),
            );
          }),
        ],
      ),
    );
  }

  Widget _floatingButton() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(child: _buildFavoriteButton(controller.id.value)),
      );
    });
  }

  Widget _error(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)?.failedToLoadClubDetails ??
                'Failed to load club details',
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.loadDetailClub(Get.arguments),
            child: Text(AppLocalizations.of(context)?.retry ?? 'Retry'),
          ),
        ],
      ),
    );
  }

  Widget _tab({bool active = false, String text = ''}) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(text,
            style: TextStyle(
              color: !active ? Colors.grey : Colors.black,
            )),
      ),
    );
  }

  Widget _buildFavoriteButton(String idTeam) {
    return GetBuilder<DetailClubController>(
      builder: (ctrl) {
        return FloatingActionButton(
          onPressed: () {
            controller.toggleFavorite(idTeam);
          },
          child: FutureBuilder<bool>(
            future: controller.favoriteHelper.isFavorite(idTeam),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _floatingButtonShimmer();
              } else {
                bool isFavorite = snapshot.data ?? false;
                return _floatingActionButton(isFavorite, context);
              }
            },
          ),
        );
      },
    );
  }

  Widget _floatingActionButton(bool isFavorite, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isFavorite ? Colors.redAccent : Colors.blueAccent,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: const Center(
        child: Icon(
          Icons.favorite,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _floatingButtonShimmer() {
    return const AppShimmer(
        child: SizedBox(
      width: double.infinity,
      height: 30,
    ));
  }
}
