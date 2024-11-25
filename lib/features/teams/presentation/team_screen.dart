import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../../components/widget/header_title_widget.dart';
import '../../../components/widget/item_club_widget.dart';
import '../../../components/widget/league_carousel_item.dart';
import '../../../components/widget/shimmer/item_list_league_shimmer_widget.dart';
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
      // backgroundColor: Colors.white,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => controller.onInit(),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _headerPage(context)),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 8.0,
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: !controller.isSearchFocused.value
                      ? HeaderTitleWidget(
                          icon: Icons.dataset,
                          label: AppLocalizations.of(context)?.listTeam ??
                              "List Team",
                        )
                      : Container());
            }),
          ),
          _bodyListTeam(context),
          SliverToBoxAdapter(
            child: Obx(() {
              return _showMoreWidgetTeam(context);
            }),
          )
        ],
      ),
    );
  }

  Widget _headerPage(BuildContext context) {
    return Stack(
      children: [
        Obx(() {
          return !controller.isSearchFocused.value
              ? Container(
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Color(0xff5c0751),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                  ),
                )
              : Container();
        }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SafeArea(
            child: Column(
              children: [
                Obx(() {
                  return _searchBar(context);
                }),
                const SizedBox(
                  height: 8,
                ),
                Obx(() {
                  return !controller.isSearchFocused.value
                      ? Container(child: _buildListLeague(context))
                      : Container();
                })
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _showMoreWidgetTeam(BuildContext context) {
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
                      ? AppLocalizations.of(context)?.showLess ?? "Show less"
                      : AppLocalizations.of(context)?.showMore ?? "Show more",
                  style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              )
            : Container(),
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        style: TextStyle(
          color: controller.isSearchFocused.value ? Colors.black : Colors.white,
        ),
        focusNode: controller.isFocusNodeSearch, // Gunakan tanpa .value
        onChanged: (query) => controller.searchTeams(query),
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)?.searchTeamByName ??
              "Search team by name",
          hintStyle: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14.0),
          prefixIconColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          prefixIcon: const Icon(Icons.search),
          helperStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
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
            return ItemClubWidget(team: listData[index]);
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

  Widget _carouselBuilder(
      List<LeagueItemModel>? listLeague, BuildContext context) {
    return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CarouselView(
            elevation: 4,
            itemSnapping: false,
            itemExtent: MediaQuery.sizeOf(context).width,
            children: List.generate(listLeague?.length ?? 0, (int index) {
              var dataLeagueItem = listLeague?[index];
              return LeagueCarouselItem(itemLeague: dataLeagueItem);
            })),
      ),
    );
  }

  Widget _buildListLeague(BuildContext context) {
    return GetBuilder<TeamController>(builder: (ctrl) {
      final state = ctrl.listLeagueState;

      if (state is ListLeagueError) {
        return Container();
      }

      if (state is ListLeagueLoading) {
        return const ItemListLeagueShimmerWidget();
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
            style: const TextStyle(fontSize: 18, color: Colors.red),
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
}
