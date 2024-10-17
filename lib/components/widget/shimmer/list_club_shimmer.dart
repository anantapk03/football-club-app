import 'package:flutter/material.dart';

import '../app_shimmer.dart';

class ListClubShimmer extends StatelessWidget {
  const ListClubShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShimmer(child: _bodyListShimmer());
  }

  Widget _bodyListShimmer() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0),
      itemBuilder: (context, index) => _itemShimmerTeam(),
      itemCount: 10,
    );
  }

  Widget _itemShimmerTeam() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildShimmerImage()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildShimmerText(),
          )
        ],
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
