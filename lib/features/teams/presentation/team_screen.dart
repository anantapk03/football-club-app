import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _searchBar(),
            ),
            SliverToBoxAdapter(child: Obx(() {
              return controller.searchQuery.value.isEmpty
                  ? Container(child: _buildListLeague(context))
                  : Container();
            })),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 8.0,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.dataset,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "List Team",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ],
                  )),
            ),
            _bodyListTeam(),
            SliverToBoxAdapter(
              child: Obx(() {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: controller.searchQuery.value.isEmpty
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
                                  ? "Show less"
                                  : "Show more",
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
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (query) => controller.searchTeams(query),
        decoration: InputDecoration(
          hintText: "Search team by name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }

  Widget _bodyListTeam() {
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
          return SliverToBoxAdapter(child: _error());
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

  Widget _carouselItem(BuildContext context, LeagueItemModel? itemLeague) {
    return Container(
      width: MediaQuery.sizeOf(context).width - 32,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: itemLeague?.strLogo == null && itemLeague?.strBadge == null
            ? Image.asset(
                "assets/images/logo_app.png",
                fit: BoxFit.cover,
                // height: 300,
              )
            : CachedNetworkImage(
                imageUrl: itemLeague?.strLogo ?? itemLeague!.strBadge ?? ""),
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
              return _carouselItem(context, dataLeagueItem);
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

  Widget _error() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          const Text(
            'Failed to load teams',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.onInit(),
            child: const Text('Retry'),
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
