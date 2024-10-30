// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/widget/app_shimmer.dart';
import '../../../components/widget/shimmer/detail_shimmer.dart';
import '../model/detail_club_model.dart';
import '../model/history_event_club_model.dart';
import 'detail_club_controller.dart';
import 'detail_club_state.dart';
import 'history_event_club_state.dart';

class DetailClubScreen extends GetView<DetailClubController> {
  const DetailClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
      floatingActionButton: Obx(() {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
              width: double.infinity,
              child: _buildFavoriteButton(controller.id.value)),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)?.detailClub ?? "Detail Club"),
      centerTitle: true,
    );
  }

  Widget _body(BuildContext context) {
    return GetBuilder<DetailClubController>(
      builder: (ctrl) {
        final state = controller.detailClubState;

        if (state is DetailClubLoading) {
          return _loading();
        }

        if (state is DetailClubLoadSuccess) {
          final eventState = ctrl.historyEventClubState;
          if (eventState is HistoryEventClubLoading) {
            return _loading();
          }

          if (eventState is HistoryEventClubError) {
            List<HistoryEventClubModel> empty = [];
            return _contentBody(state.detail, empty, context);
          }

          if (eventState is HistoryEventClubLoadSuccess) {
            return _contentBody(state.detail, eventState.listHistory, context);
          }
        }

        if (state is DetailClubError) {
          return _error(context);
        }

        return Container();
      },
    );
  }

  Widget _loading() => const DetailShimmer();

  Widget _error(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)?.failedToLoadClubDetails ??
                'Failed to load club details',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.loadDetailClub(Get.arguments),
            child: Text(AppLocalizations.of(context)?.retry ?? 'Retry'),
          ),
        ],
      ),
    );
  }

  Widget _contentBody(DetailClubModel detailClub,
      List<HistoryEventClubModel> listHistoryEvent, BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CachedNetworkImage(
                imageUrl: detailClub.badge!,
                width: 200,
                height: 200,
                placeholder: (context, url) => _buildShimmerImage(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                detailClub.nameTeam!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            _headerTitle(
                Icons.info, AppLocalizations.of(context)?.info ?? "Info"),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${AppLocalizations.of(context)?.yearEstablished ?? "Year Established"}: ${detailClub.formedYear},\n${AppLocalizations.of(context)?.stadionLocation ?? "Location Stadion"} : ${detailClub.stadion}",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 16,
            ),
            _headerTitle(Icons.description,
                AppLocalizations.of(context)?.description ?? "Description"),
            const SizedBox(
              height: 8.0,
            ),
            Obx(() {
              return Text(
                detailClub.description!,
                textAlign: TextAlign.justify,
                maxLines: controller.isFullDetailDescription.value ? null : 3,
                overflow: controller.isFullDetailDescription.value
                    ? null
                    : TextOverflow.ellipsis,
              );
            }),
            const SizedBox(
              height: 8.0,
            ),
            GestureDetector(
              onTap: () {
                controller.isFullDetailDescription.value =
                    !controller.isFullDetailDescription.value;
              },
              child: Obx(() {
                return Center(
                  child: Text(
                    controller.isFullDetailDescription.value
                        ? AppLocalizations.of(context)?.readLess ?? "Read less"
                        : AppLocalizations.of(context)?.readMore ?? "Read more",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8.0),
            _headerTitle(Icons.cloud_circle,
                AppLocalizations.of(context)?.socialMedia ?? "Social Media"),
            const SizedBox(
              height: 10.0,
            ),
            _socialMediaLinks(detailClub),
            const SizedBox(
              height: 18,
            ),
            _headerTitle(Icons.event,
                AppLocalizations.of(context)?.historyEvent ?? "History Event"),
            const SizedBox(
              height: 12.0,
            ),
            Container(
              // Ubah Expanded menjadi Container
              // Berikan tinggi yang sesuai
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ]),
              child: _historyEventList(listHistoryEvent, context),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _headerTitle(IconData icon, String label) {
    return Row(
      children: [
        Icon(
          icon,
          weight: 10.0,
          color: Colors.grey,
        ),
        SizedBox(
          width: 5.0,
        ),
        Text(
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          label,
        ),
      ],
    );
  }

  Widget _socialMediaLinks(DetailClubModel detailClub) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _socialMediaIcon(
          detailClub.facebookUrl ?? "www.facebook.com/anantapadmakusuma5",
          Icons.facebook,
          Colors.blue,
        ),
        const SizedBox(width: 16),
        _socialMediaIcon(
          detailClub.instagramUrl ?? "www.instagram.com/anantapk03",
          Icons.camera_alt,
          Colors.pink,
        ),
        const SizedBox(width: 16),
        _socialMediaIcon(
          detailClub.twitterUrl ?? "www.x.com/anantapk03",
          Icons.alternate_email,
          Colors.lightBlue,
        ),
      ],
    );
  }

  Widget _socialMediaIcon(String? url, IconData icon, Color color) {
    return GestureDetector(
      onTap: () async {
        var newUrl = "https://$url";
        newUrl.toString();
        try {
          await _launchURL(newUrl);
        } catch (e) {
          Logger().i(e.toString());
        }
      },
      child: Icon(icon, color: color, size: 30),
    );
  }

  Widget _buildFavoriteButton(String idTeam) {
    return GetBuilder<DetailClubController>(
      builder: (ctrl) {
        return FloatingActionButton(
          onPressed: () {
            controller.toggleFavorite(idTeam);
          },
          child: FutureBuilder<bool>(
            future: controller.favoriteHelper.isFavorite(idTeam),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _floatingButtonShimmer();
              } else {
                bool isFavorite = snapshot.data ?? false;
                return _floatingActionButton(isFavorite, context);
              }
            },
          ),
        );
      },
    );
  }

  Widget _floatingActionButton(bool isFavorite, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isFavorite ? Colors.redAccent : Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            isFavorite
                ? AppLocalizations.of(context)?.setAsFavorite ??
                    "Set as Favorite"
                : AppLocalizations.of(context)?.favorite ?? "Favorite",
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildShimmerImage() {
    return AppShimmer(
        child: Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
    ));
  }

  Widget _floatingButtonShimmer() {
    return AppShimmer(
        child: SizedBox(
      width: double.infinity,
      height: 30,
    ));
  }

  Widget _historyEventItem(HistoryEventClubModel? data, BuildContext context) {
    var date = _convertDate(data?.dateEvent ?? "2003-09-05");
    return Container(
      width: MediaQuery.sizeOf(context).width - 40,
      padding: EdgeInsets.all(16.0),
      height: 300,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            data?.strLeague ?? "BRI Liga",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.blue),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  data?.strHomeTeamBadge != null
                      ? CachedNetworkImage(
                          imageUrl: data?.strHomeTeamBadge ?? "",
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
                  Text(data?.strHomeTeam ?? "Arema",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 12)),
                ],
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                "VS",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              ),
              SizedBox(
                width: 8.0,
              ),
              Column(
                children: [
                  data?.strHomeTeamBadge != null
                      ? CachedNetworkImage(
                          imageUrl: data?.strAwayTeamBadge ?? "",
                          width: 40,
                          height: 40,
                        )
                      : Image.asset(
                          "assets/images/logo_app.png",
                          width: 40,
                          height: 40,
                        ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    data?.strAwayTeam ?? "Persija",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          // Menambahkan tampilan skor hasil pertandingan
          Text(
            "${data?.intHomeScore ?? 0} - ${data?.intAwayScore ?? 0}",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 12,
          ),
          Text(date ?? "24 Juli 2024")
        ],
      ),
    );
  }

  String? _convertDate(String? date) {
    print("date Event : $date");
    if (date == null) return null;

    try {
      // Parsing tanggal dengan format "dd-MM-yyyy"
      DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);

      // Mengonversi tanggal ke format "d MMMM yyyy"
      String formattedDate = DateFormat('d MMMM yyyy').format(parsedDate);

      return formattedDate;
    } catch (e) {
      // Jika terjadi kesalahan parsing
      print("Error parsing : $e");
      return null;
    }
  }

  Widget _historyEventList(
      List<HistoryEventClubModel> listData, BuildContext context) {
    if (listData.isNotEmpty) {
      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listData.length,
          itemBuilder: (context, index) {
            final historyEvent = listData[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _historyEventItem(historyEvent, context),
            );
          });
    } else {
      return Center(
        child: Text(AppLocalizations.of(context)?.emptyHistoryEvent ??
            "Empty History Event"),
      );
    }
  }
}
