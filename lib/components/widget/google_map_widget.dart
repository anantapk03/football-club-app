import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../features/detailclub/model/detail_club_model.dart';

class GoogleMapWidget extends StatelessWidget {
  final double? longitude;
  final double? latitude;
  final DetailClubModel? detailClubModel;
  const GoogleMapWidget(
      {super.key, this.latitude, this.detailClubModel, this.longitude});

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition: CameraPosition(
        target: longitude == 0.0
            ? const LatLng(52.4862, -1.8904)
            : LatLng(latitude ?? 0.0, longitude ?? 0.0),
        zoom: 8.4746,
      ),
      markers: {
        Marker(
            markerId: MarkerId(
              detailClubModel?.idTeam ?? "",
            ),
            position: LatLng(latitude ?? 0.0, longitude ?? 0.0),
            infoWindow: InfoWindow(
              title: detailClubModel?.stadion,
            ))
      },
    );
  }
}
