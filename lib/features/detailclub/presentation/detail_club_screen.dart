import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:logger/logger.dart';
import '../model/detail_club_model.dart';
import 'detail_club_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail_club_state.dart';

class DetailClubScreen extends GetView<DetailClubController> {
  const DetailClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String idTeam = Get.arguments;
    controller.loadDetailClub(idTeam);
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      floatingActionButton: _buildFavoriteButton(idTeam),
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

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _error() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red, size: 64),
          SizedBox(height: 16),
          Text(
            'Failed to load club details',
            style: TextStyle(fontSize: 18, color: Colors.red),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.loadDetailClub(Get.arguments),
            child: Text('Retry'),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          CachedNetworkImage(
            imageUrl: detailClub.badge!,
            width: 200,
            height: 200,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          SizedBox(height: 16),
          Text(
            'Founded: ${detailClub.formedYear}',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          Text(
            detailClub.description!,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 16),
          _socialMediaLinks(detailClub),
          SizedBox(height: 16),
          FutureBuilder<bool>(
            future: controller.favoriteHelper.isFavorite(detailClub.idTeam!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
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
        SizedBox(width: 16),
        _socialMediaIcon(
          detailClub.instagramUrl.toString(),
          Icons.camera_alt,
          Colors.pink,
        ),
        SizedBox(width: 16),
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
        var newUrl = "https://${url}";
        newUrl.toString();
        try{
          await launchURL(newUrl);
        } catch(e){
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
                return CircularProgressIndicator();
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
}

Future<void> launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    throw 'Could not launch $url';
  }  
}