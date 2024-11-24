import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../components/widget/app_shimmer.dart';
import '../../../components/widget/google_map_widget.dart';
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
        headerSliverBuilder: (context, value) => [
          SliverAppBar(
            expandedHeight: MediaQuery.sizeOf(context).width / 2,
            pinned: true,
            snap: false,
            floating: false,
            title: Text(detailClub.nameTeam ?? ""),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _headerDetailClub(detailClub, context),
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
                    height: 59,
                    child: _tab(
                        active: controller.selectedItem.value == 0,
                        text:
                            AppLocalizations.of(context)?.aboutTeam ?? "About"),
                  );
                }),
                Obx(() {
                  return Tab(
                    height: 59,
                    child: _tab(
                        active: controller.selectedItem.value == 1,
                        text: AppLocalizations.of(context)?.historyJersey ??
                            "History Jersey"),
                  );
                }),
              ],
            ),
          )
        ],
        body: RefreshIndicator(
          onRefresh: () async => controller.onInit(),
          child: Padding(
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

  Widget _headerDetailClub(DetailClubModel detailClub, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).width / 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: detailClub.badge!,
                width: 90,
                height: 90,
                placeholder: (context, url) => _buildShimmerImage(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detailClub.nameTeam ?? "",
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.start, // Menghindari teks tidak rapi
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "${AppLocalizations.of(context)?.yearEstablished ?? "Year Established"} : ${detailClub.formedYear}",
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (detailClub.stadion != null) {
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
                                    heightFactor:
                                        0.35, // Menggunakan 90% dari tinggi layar
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: _googleMaps(detailClub),
                                    ),
                                  );
                                });
                          }
                        },
                        child: Text(
                          detailClub.stadion ?? "Unknown",
                          style: TextStyle(
                              color: detailClub.stadion == null
                                  ? Colors.black
                                  : Colors.blue),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _tab({bool active = false, String text = ''}) {
    return Center(
      child: Text(text,
          style: TextStyle(
            color: !active ? Colors.grey : Colors.black,
          )),
    );
  }

  Widget _googleMaps(DetailClubModel detailClub) {
    return detailClub.stadion != null
        ? SizedBox(
            height: 200,
            child: GoogleMapWidget(
              longitude: controller.longitude.value,
              latitude: controller.latitude.value,
              detailClubModel: detailClub,
            ),
          )
        : Container();
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

  Widget _buildShimmerImage() {
    return AppShimmer(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    ));
  }

  Widget _floatingButtonShimmer() {
    return const AppShimmer(
        child: SizedBox(
      width: double.infinity,
      height: 30,
    ));
  }
}
