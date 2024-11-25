import 'package:flutter/material.dart';

import '../app_shimmer.dart';

class ItemListLeagueShimmerWidget extends StatelessWidget {
  const ItemListLeagueShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.white),
      ),
    ));
  }
}
