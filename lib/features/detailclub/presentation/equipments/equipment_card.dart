import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../components/widget/app_shimmer.dart';
import '../../model/equipment_item_model.dart';

class EquipmentCard extends StatelessWidget {
  final EquipmentItemModel? itemModel;
  const EquipmentCard({super.key, this.itemModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Hero(
                    tag: itemModel?.strUsername ?? "",
                    child: CachedNetworkImage(
                      imageUrl: itemModel?.strEquipment ?? "",
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
                  child: itemModel?.strSeason == null
                      ? _buildShimmerText()
                      : Text(
                          itemModel?.strSeason ?? "",
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
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 30,
              width: 40,
              decoration: const BoxDecoration(
                  color: Color(0xff5c0751),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0))),
              child: Center(
                child: Text(
                  itemModel?.strType ?? "1st",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
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
      color: Colors.white,
    ));
  }

  Widget _buildShimmerText() {
    return AppShimmer(
        child: Container(width: 100, height: 16, color: Colors.white));
  }
}
