import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/history_event_club_model.dart';

class HistoryEventCard extends StatelessWidget {
  final HistoryEventClubModel? clubModel;

  const HistoryEventCard({super.key, required this.clubModel});

  @override
  Widget build(BuildContext context) {
    var date = _convertDate(clubModel?.dateEvent ?? "2003-09-05");
    var initialAwayTeam = _getInitials(clubModel?.strAwayTeam);
    var initialTeam = _getInitials(clubModel?.strHomeTeam);
    return Container(
      width: MediaQuery.sizeOf(context).width,
      padding: const EdgeInsets.all(16.0),
      height: 200,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            clubModel?.strLeague ?? "BRI Liga",
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.blue),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  clubModel?.strHomeTeamBadge != null
                      ? CachedNetworkImage(
                          imageUrl: clubModel?.strHomeTeamBadge ?? "",
                          width: 40,
                          height: 40,
                        )
                      : Image.asset(
                          "assets/images/logo_app.png",
                          width: 40,
                          height: 40,
                        ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(initialTeam,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 12)),
                ],
              ),
              const Text(
                "VS",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              ),
              Column(
                children: [
                  clubModel?.strHomeTeamBadge != null
                      ? CachedNetworkImage(
                          imageUrl: clubModel?.strAwayTeamBadge ?? "",
                          width: 40,
                          height: 40,
                        )
                      : Image.asset(
                          "assets/images/logo_app.png",
                          width: 40,
                          height: 40,
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    initialAwayTeam,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          // Menambahkan tampilan skor hasil pertandingan
          Text(
            "${clubModel?.intHomeScore ?? 0} - ${clubModel?.intAwayScore ?? 0}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(date ?? "24 Juli 2024")
        ],
      ),
    );
  }

  String? _convertDate(String? date) {
    if (date == null) return null;
    try {
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
      String formattedDate = DateFormat('d MMMM yyyy').format(parsedDate);
      return formattedDate;
    } catch (e) {
      return null;
    }
  }

  String _getInitials(String? data) {
    // Membagi string menjadi kata-kata dan mengambil huruf pertama dari setiap kata
    String name = data ?? "Football Club";
    List<String> words = name.split(' ');
    String initials = '';

    for (var word in words) {
      if (word.isNotEmpty) {
        initials += word[0]
            .toUpperCase(); // Mengambil huruf pertama dan mengubahnya menjadi huruf kapital
      }
    }
    print("Initials = $initials");
    return initials;
  }
}
