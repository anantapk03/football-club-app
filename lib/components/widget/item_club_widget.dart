import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/teams/model/team_model.dart';
import '../config/app_route.dart';
import 'app_shimmer.dart';

class ItemClubWidget extends StatelessWidget {
  final TeamModel? team;
  const ItemClubWidget({super.key, this.team});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.detail, arguments: team?.idTeam);
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
                  tag: team?.nameTeam ?? "",
                  child: CachedNetworkImage(
                    imageUrl: team?.badge ?? "",
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
                child: team?.nameTeam == null
                    ? _buildShimmerText()
                    : Text(
                        team?.nameTeam ?? "",
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

  Widget _buildShimmerText() {
    return AppShimmer(
        child: Container(width: 100, height: 16, color: Colors.white));
  }
}
