import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/config/app_route.dart';
import '../../../components/config/app_style.dart';
import '../../detailclub/model/detail_club_model.dart';
import 'favorite_controller.dart';
import 'favorite_state.dart';

class FavoriteScreen extends GetView<FavoriteController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return GetBuilder<FavoriteController>(
      builder: (ctrl) {
        final state = ctrl.favoriteState.value;

        if (state is FavoriteLoading) {
          return _loading();
        }

        if (state is FavoriteLoadSuccess) {
          if (state.listClub.isEmpty) {
            return _emptyState();
          } else {
            return _contentBody(state.listClub);
          }
        }
        return Container();
      },
    );
  }

  Widget _loading() => const Center(child: CircularProgressIndicator(),);

  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No favorites yet!',
            style: TextStyle(fontSize: 24, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _contentBody(List<DetailClubModel> listClub) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30
      ),
      child: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: listClub.length,
        itemBuilder: (context, index) {
          final club = listClub[index];
          return _itemClub(club);
        },
      ),
    );
  }

  Widget _itemClub(DetailClubModel item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoute.detail, arguments: item.idTeam!);
      },
      child: _cardItem(item),
    );
  }

  Widget _cardItem(DetailClubModel item){
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: item.nameTeam!,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: CachedNetworkImage(
                    imageUrl: item.badge!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                color: AppStyle.appthemeAccent,
              ),
              child: Text(
                item.nameTeam!,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );   
  }
}
