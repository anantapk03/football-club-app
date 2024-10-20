import 'package:flutter/material.dart';

import '../app_shimmer.dart';

class ListClubShimmer extends StatelessWidget {
  const ListClubShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _bodyListShimmer();
  }

  Widget _bodyListShimmer() {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (context, index) => _itemShimmerTeam(),
      itemCount: 10,
      physics:
          const NeverScrollableScrollPhysics(), // Non-scrollable to prevent conflict
      shrinkWrap: true, // Allows GridView to take minimal height
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
          Expanded(
              child:
                  _buildShimmerImage()), // Ensures proper layout with Expanded
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildShimmerText(),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerImage() {
    return AppShimmer(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[300], // Shimmer color
      ),
    );
  }

  Widget _buildShimmerText() {
    return AppShimmer(
      child: Container(
        width: 100,
        height: 16,
        color: Colors.grey[300], // Shimmer color
      ),
    );
  }
}
