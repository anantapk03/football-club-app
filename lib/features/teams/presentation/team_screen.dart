import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../components/config/app_route.dart';
import '../../../components/widget/app_shimmer.dart';
import '../../../components/widget/shimmer/list_club_shimmer.dart';
import '../model/league_item_model.dart';
import '../model/team_model.dart';
import 'list_league_state.dart';
import 'team_controller.dart';
import 'team_state.dart';

class TeamScreen extends GetView<TeamController> {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.onInit();
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _searchBar(context),
              ),
              // SliverToBoxAdapter(child: Obx(() {
              //   return controller.searchQuery.value.isEmpty
              //       ? Container(child: _buildListLeague(context))
              //       : Container();
              // })),
              SliverToBoxAdapter(child: Obx(() {
                return !controller.isSearchFocused
                        .value // Memeriksa apakah search bar fokus
                    ? Container(
                        child: _buildListLeague(
                            context)) // Jika tidak fokus, tampilkan list
                    : Container();
              })),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 8.0,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.dataset,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          AppLocalizations.of(context)?.listTeam ?? "List Team",
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
                    )),
              ),
              _bodyListTeam(context),
              SliverToBoxAdapter(
                child: Obx(() {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: !controller.isSearchFocused.value
                          ? GestureDetector(
                              onTap: () {
                                if (controller.isShowMore.value) {
                                  controller.isShowMore.value = false;
                                } else {
                                  controller.isShowMore.value = true;
                                }
                              },
                              child: Text(
                                controller.isShowMore.value
                                    ? AppLocalizations.of(context)?.showLess ??
                                        "Show less"
                                    : AppLocalizations.of(context)?.showMore ??
                                        "Show more",
                                style: const TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          : Container(),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Obx(() {
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            focusNode: controller.isFocusNodeSearch.value,
            onChanged: (query) => controller.searchTeams(query),
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)?.searchTeamByName ??
                  "Search team by name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.transparent,
            ),
          ));
    });
  }

  Widget _bodyListTeam(BuildContext context) {
    return GetBuilder<TeamController>(
      builder: (ctrl) {
        final state = controller.teamState;

        if (state is TeamLoading) {
          return SliverToBoxAdapter(child: _loading());
        }

        if (state is TeamLoadSuccess) {
          return _contentBody(controller.searchResults);
        }

        if (state is TeamError) {
          return SliverToBoxAdapter(child: _error(context));
        }

        return SliverToBoxAdapter(child: Container());
      },
    );
  }

  Widget _contentBody(List<TeamModel> listData) {
    return Obx(() {
      return SliverPadding(
        padding: const EdgeInsets.all(8.0),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) {
            return _itemTeam(listData[index]);
          },
              childCount: controller.isShowMore.value
                  ? listData.length
                  : controller.searchQuery.value.isNotEmpty
                      ? controller.searchResults.length
                      : 4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        ),
      );
    });
  }

  Widget _carouselItemCustom(
      BuildContext context, LeagueItemModel? itemLeague) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 168,
        decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: NetworkImage(
                    itemLeague?.strLogo ?? itemLeague!.strBadge ?? ""),
                fit: BoxFit.contain)),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black,
                      ])),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    itemLeague?.strLeague ?? "",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _carouselBuilder(
      List<LeagueItemModel>? listLeague, BuildContext context) {
    return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CarouselView(
            elevation: 4,
            itemSnapping: true,
            itemExtent: MediaQuery.sizeOf(context).width,
            children: List.generate(listLeague?.length ?? 0, (int index) {
              var dataLeagueItem = listLeague?[index];
              return _carouselItemCustom(context, dataLeagueItem);
            })),
      ),
    );
  }

  Widget _buildListLeague(BuildContext context) {
    return GetBuilder<TeamController>(builder: (ctrl) {
      final state = controller.listLeagueState;

      if (state is ListLeagueError) {
        return Container();
      }

      if (state is ListLeagueLoading) {
        return _buildShimmerCarousel();
      }

      if (state is LisLeagueLoadSuccess) {
        return _carouselBuilder(state.listLeague, context);
      }

      return Container();
    });
  }

  Widget _loading() => const ListClubShimmer();

  Widget _error(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)?.failedToLoadTeams ??
                "Failed to Load Teams",
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.onInit(),
            child: Text(AppLocalizations.of(context)?.retry ?? 'Retry'),
          ),
        ],
      ),
    );
  }

  Widget _itemTeam(TeamModel team) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.detail, arguments: team.idTeam);
      },
      child: SizedBox(
        width: 50,
        height: 10,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Hero(
                  tag: team.nameTeam!,
                  child: CachedNetworkImage(
                    imageUrl: team.badge!,
                    fit: BoxFit.contain,
                    placeholder: (context, url) =>
                        Center(child: _buildShimmerImage()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: team.nameTeam == null
                    ? _buildShimmerText()
                    : Text(
                        team.nameTeam!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
              ),
            ],
          ),
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

  Widget _buildShimmerCarousel() {
    return AppShimmer(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
      ),
    ));
  }

  Widget _buildShimmerText() {
    return AppShimmer(
        child: Container(width: 100, height: 16, color: Colors.white));
  }
}
