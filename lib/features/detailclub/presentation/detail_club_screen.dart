// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      appBar: _appBar(),
      body: _body(),
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

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("Detail Club"),
      centerTitle: true,
    );
  }

  Widget _body() {
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
            return _contentBody(state.detail, empty);
          }

          if (eventState is HistoryEventClubLoadSuccess) {
            return _contentBody(state.detail, eventState.listHistory);
          }
        }

        if (state is DetailClubError) {
          return _error();
        }

        return Container();
      },
    );
  }

  Widget _loading() => const DetailShimmer();

  Widget _error() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          const Text(
            'Failed to load club details',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.loadDetailClub(Get.arguments),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _contentBody(DetailClubModel detailClub,
      List<HistoryEventClubModel> listHistoryEvent) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
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
            Text(
              "Info",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Year Established : ${detailClub.formedYear},\nLocation Stadion : ${detailClub.stadion}",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Description",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
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
                        ? "Read less"
                        : "Read more",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8.0),
            Text(
              "Social Media",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8.0,
            ),
            _socialMediaLinks(detailClub),
            const SizedBox(
              height: 16,
            ),
            Text(
              "History Events",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              // Ubah Expanded menjadi Container
              height: 300, // Berikan tinggi yang sesuai
              child: _historyEventList(listHistoryEvent),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
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
                return _floatingActionButton(isFavorite);
              }
            },
          ),
        );
      },
    );
  }

  Widget _floatingActionButton(bool isFavorite) {
    return Container(
      decoration: BoxDecoration(
        color: isFavorite ? Colors.redAccent : Colors.blueAccent,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            isFavorite ? "Set as Favorite" : "Favorite",
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

  Widget _historyEventItem(HistoryEventClubModel? data) {
    return Container(
      padding: EdgeInsets.all(8.0),
      width: double.infinity, // Mengatur lebar item
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
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
              CachedNetworkImage(
                imageUrl: data?.strHomeTeamBadge ?? "",
                width: 30,
                height: 30,
              ),
              Text(data?.strHomeTeam ?? "Arema"),
              Text(
                "VS",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.red),
              ),
              Text(data?.strAwayTeam ?? "Persija"),
              CachedNetworkImage(
                imageUrl: data?.strAwayTeamBadge ?? "",
                width: 30,
                height: 30,
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
          Text(data?.dateEvent ?? "24-07-2024")
        ],
      ),
    );
  }

  Widget _historyEventList(List<HistoryEventClubModel> listData) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.vertical,
        itemCount: listData.length,
        itemBuilder: (context, index) {
          final historyEvent = listData[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: _historyEventItem(historyEvent),
          );
        });
  }
}
