// import 'package:cached_network_image/cached_network_imageg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/config/app_route.dart';
import '../../../components/widget/app_shimmer.dart';
import '../../../components/widget/shimmer/list_club_shimmer.dart';
import '../model/team_model.dart';
import 'team_controller.dart';
import 'team_state.dart';

class TeamScreen extends GetView<TeamController> {
  const TeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Search Bar Section
            SliverToBoxAdapter(
              child: _searchBar(),
            ),
            // Body Content Section
            GetBuilder<TeamController>(
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
            ),
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

  Widget _contentBody(List<TeamModel> listData) {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _itemTeam(listData[index]);
          },
          childCount: listData.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
      ),
    );
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
        print("id team ${team.idTeam}");
        Get.toNamed(AppRoute.detail, arguments: team.idTeam);
      },
      child: Card(
        elevation: 4,
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
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Center(child: _buildShimmerImage()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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

  Widget _buildShimmerText() {
    return AppShimmer(
        child: Container(width: 100, height: 16, color: Colors.white));
  }
}
