import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../components/services/database/app_database.dart';
import '../../../components/util/favorite_helper.dart';
import '../../../components/util/firebase_notification_util.dart';
import '../../../components/util/helper.dart';
import '../../../components/util/state.dart';
import '../../../notification_services.dart';
import '../../favorite/presentation/favorite_controller.dart';
import '../../profile/presentation/profile_controller.dart';
import '../model/detail_club_model.dart';
import '../model/history_event_club_model.dart';
import '../repository/detailclub_repository.dart';
import 'detail_club_state.dart';
import 'equipments/equipment_screen.dart';
import 'history_event/history_event_screen.dart';
import 'history_event_club_state.dart';

class DetailClubController extends GetxController {
  final DetailclubRepository _repository;
  DetailClubState detailClubState = DetailClubIdle();
  HistoryEventClubState historyEventClubState = HistoryEventClubIdle();
  final FavoriteHelper _favoriteHelper;
  final AppDatabase _appDatabase;
  final _logger = Logger();
  final isFullDetailDescription = false.obs;
  DetailClubController(
      this._repository, this._favoriteHelper, this._appDatabase);
  List<HistoryEventClubModel>? listHistoryClub = [];
  Rx<double> latitude = 0.0.obs;
  Rx<double> longitude = 0.0.obs;
  Rx<int> selectedItem = 0.obs;

  FavoriteHelper get favoriteHelper => _favoriteHelper;

  NotificationService notificationService = NotificationService();

  final id = "".obs;
  final idFromParameters = "".obs;
  final idFromArguments = "".obs;
  late List<Widget> widgetTabs;
  late DetailClubModel detailClub;
  @override
  void onInit() async {
    super.onInit();
    idFromArguments.value = Get.arguments ?? "";
    idFromParameters.value = Get.parameters['id'] ?? "";
    if (id.value.isEmpty) {
      if (idFromParameters.value.isEmpty) {
        id.value = idFromArguments.value;
      } else {
        id.value = idFromParameters.value;
      }
    }
    await loadDetailClub(id.value);
    widgetTabs = [
      HistoryEventScreen(
        id: id.value,
        // detailClub: detailClub,
      ),
      EquipmentScreen(
        idTeam: id.value,
      )
    ];
    firebaseController();
    selectedItem.value = 0;
  }

  Future<void> loadDetailClub(String idTeam) async {
    detailClubState = DetailClubLoading();
    update();
    _repository.loadDetail(
      response: ResponseHandler(
        onSuccess: (listItem) async {
          DetailClubModel? foundItem;

          for (var item in listItem) {
            if (item.idTeam == idTeam) {
              foundItem = item;
              break;
            }
          }

          if (foundItem != null) {
            await getLocationTeam(foundItem.location ?? foundItem.stadion);
            detailClubState = DetailClubLoadSuccess(foundItem);
            detailClub = foundItem;
          } else {
            detailClubState = DetailClubError();
          }

          update();
        },
        onFailed: (e, message) {
          _logger.e(e);
          AlertModel.showBasic("Error", message);
          detailClubState = DetailClubError();
          update();
        },
        onDone: () {},
      ),
    );
  }

  Future<void> getLocationTeam(String? address) async {
    try {
      List<Location> locations = await locationFromAddress(address ?? "London");

      if (locations.isNotEmpty) {
        latitude.value = locations[0].latitude;
        longitude.value = locations[0].longitude;
      }
    } catch (e) {
      Logger().i('Error: $e');
    }
  }

  Future<void> toggleFavorite(String idTeam) async {
    bool isFavorite = await _favoriteHelper.isFavorite(idTeam);
    DetailClubModel? detailClub = (detailClubState is DetailClubLoadSuccess)
        ? (detailClubState as DetailClubLoadSuccess).detail
        : null;

    if (isFavorite) {
      await _favoriteHelper.removeFavorite(idTeam);
      FirebaseNotificationUtil().unsubscribeTopic(idTeam);
      await (_appDatabase.delete(_appDatabase.clubTable)
            ..where((club) => club.idTeam.equals(idTeam)))
          .go(); // Penulisan delete dengan Drift
    } else {
      if (detailClub != null) {
        await _favoriteHelper.addFavorite(detailClub);
        FirebaseNotificationUtil().subscribeTopic(idTeam);
        await _appDatabase.into(_appDatabase.clubTable).insert(
            ClubTableCompanion.insert(
                idTeam: idTeam,
                nameTeam: detailClub.nameTeam ?? "",
                badge: detailClub.badge ?? "",
                formedYear: detailClub.formedYear ?? "",
                description: detailClub.description ?? "",
                facebookUrl: detailClub.facebookUrl ?? "",
                twitterUrl: detailClub.twitterUrl ?? "",
                instagramUrl: detailClub.instagramUrl ?? "",
                stadion: detailClub.stadion ?? ""));
      }
    }

    List<ClubTableData> allClubinDatabase =
        await _appDatabase.select(_appDatabase.clubTable).get();
    _logger.i("List Club on SQLite : ${allClubinDatabase.length}");
    update();
    Get.find<FavoriteController>().loadAllClubFavorite();
    Get.find<ProfileController>().getTotalFavorite();
  }

  void firebaseController() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        id.value = message.data['id'];
        loadDetailClub(id.value);
      }
    });
  }

  void onItemTapped(int value) {
    selectedItem.value = value;
  }
}
