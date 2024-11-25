import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../features/detailclub/model/detail_club_model.dart';
import 'app_shimmer.dart';
import 'google_map_widget.dart';

class HeaderDetailClubWidget extends StatelessWidget {
  final DetailClubModel? detailClub;
  final double? longitude;
  final double? latitude;
  const HeaderDetailClubWidget(
      {super.key, this.detailClub, this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).width / 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: detailClub?.badge ?? "",
                width: 90,
                height: 90,
                placeholder: (context, url) => _buildShimmerImage(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      detailClub?.nameTeam ?? "",
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                      textAlign: TextAlign.start, // Menghindari teks tidak rapi
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "${AppLocalizations.of(context)?.yearEstablished ?? "Year Established"} : ${detailClub?.formedYear ?? ""}",
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    GestureDetector(
                        onTap: () async {
                          if (detailClub?.stadion != null) {
                            await showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                clipBehavior: Clip.antiAlias,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                builder: (ctx) {
                                  return FractionallySizedBox(
                                    heightFactor:
                                        0.35, // Menggunakan 90% dari tinggi layar
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: _googleMaps(
                                          detailClub ?? DetailClubModel()),
                                    ),
                                  );
                                });
                          }
                        },
                        child: Text(
                          detailClub?.stadion ?? "Unknown",
                          style: TextStyle(
                              color: detailClub?.stadion == null
                                  ? Colors.black
                                  : Colors.blue),
                        ))
                  ],
                ),
              ),
            ],
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

  Widget _googleMaps(DetailClubModel detailClub) {
    return detailClub.stadion != null
        ? SizedBox(
            height: 200,
            child: GoogleMapWidget(
              longitude: longitude,
              latitude: latitude,
              detailClubModel: detailClub,
            ),
          )
        : Container();
  }
}
