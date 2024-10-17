// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/widget/shimmer/detail_shimmer.dart';
import '../model/detail_club_model.dart';
import 'detail_club_controller.dart';
import 'detail_club_state.dart';

class DetailClubScreen extends GetView<DetailClubController> {
  const DetailClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: Obx(() {
        return _buildFavoriteButton(controller.id.value);
      }),
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
          return _contentBody(state.detail);
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

  Widget _contentBody(DetailClubModel detailClub) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            detailClub.nameTeam!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CachedNetworkImage(
            imageUrl: detailClub.badge!,
            width: 200,
            height: 200,
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(height: 16),
          Text(
            'Founded: ${detailClub.formedYear}',
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            'Stadium: ${detailClub.stadion!}',
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          Text(
            detailClub.description!,
            textAlign: TextAlign.justify,
          ),
          const SizedBox(height: 16),
          _socialMediaLinks(detailClub),
          const SizedBox(height: 16),
          FutureBuilder<bool>(
            future: controller.favoriteHelper.isFavorite(detailClub.idTeam!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  bool isFavorite = snapshot.data ?? false;
                  return IconButton(
                    onPressed: () {
                      controller.toggleFavorite(detailClub.idTeam!);
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _socialMediaLinks(DetailClubModel detailClub) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialMediaIcon(
          detailClub.facebookUrl.toString(),
          Icons.facebook,
          Colors.blue,
        ),
        const SizedBox(width: 16),
        _socialMediaIcon(
          detailClub.instagramUrl.toString(),
          Icons.camera_alt,
          Colors.pink,
        ),
        const SizedBox(width: 16),
        _socialMediaIcon(
          detailClub.twitterUrl.toString(),
          Icons.alternate_email,
          Colors.lightBlue,
        ),
      ],
    );
  }

  Widget _socialMediaIcon(String? url, IconData icon, Color color) {
    if (url == null || url.isEmpty) {
      return Container();
    }
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
      child: Icon(icon, color: color, size: 36),
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
                return const CircularProgressIndicator();
              } else {
                bool isFavorite = snapshot.data ?? false;
                return Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey,
                );
              }
            },
          ),
        );
      },
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
}
