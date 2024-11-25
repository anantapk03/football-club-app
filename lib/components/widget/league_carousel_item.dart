import 'package:flutter/material.dart';

import '../../features/teams/model/league_item_model.dart';

class LeagueCarouselItem extends StatelessWidget {
  final LeagueItemModel? itemLeague;
  const LeagueCarouselItem({super.key, this.itemLeague});

  @override
  Widget build(BuildContext context) {
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
                    maxLines: 1, // Ensures it only takes one line
                    overflow: TextOverflow.ellipsis,
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
}
