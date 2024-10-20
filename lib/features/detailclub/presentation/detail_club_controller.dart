import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../components/util/favorite_helper.dart';
import '../../../components/util/firebase_notification_util.dart';
import '../../../components/util/helper.dart';
import '../../../components/util/state.dart';
import '../../../notification_services.dart';
import '../../favorite/presentation/favorite_controller.dart';
import '../model/detail_club_model.dart';
import '../model/history_event_club_model.dart';
import '../repository/detailclub_repository.dart';
import 'detail_club_state.dart';
import 'history_event_club_state.dart';

class DetailClubController extends GetxController {
  final DetailclubRepository _repository;
  DetailClubState detailClubState = DetailClubIdle();
  HistoryEventClubState historyEventClubState = HistoryEventClubIdle();
  final FavoriteHelper _favoriteHelper;
  final _logger = Logger();
  final isFullDetailDescription = false.obs;
  DetailClubController(this._repository, this._favoriteHelper);
  List<HistoryEventClubModel>? listHistoryClub = [];

  FavoriteHelper get favoriteHelper => _favoriteHelper;

  NotificationService notificationService = NotificationService();

  final id = "".obs;
  final idFromParameters = "".obs;
  final idFromArguments = "".obs;

  @override
  void onInit() async {
    super.onInit();
    idFromArguments.value = Get.arguments ?? "";
    idFromParameters.value = Get.parameters['id'] ?? "";
    if (idFromParameters.value.isEmpty) {
      id.value = idFromArguments.value;
    } else {
      id.value = idFromParameters.value;
    }
    loadDetailClub(id.value);
    await loadListHistoryEventClub();
    firebaseController();
  }

  void loadDetailClub(String idTeam) {
    detailClubState = DetailClubLoading();
    update();
    _repository.loadDetail(
        response: ResponseHandler(onSuccess: (listItem) {
      DetailClubModel? foundItem;

      for (var item in listItem) {
        if (item.idTeam == idTeam) {
          foundItem = item;
          break;
        }
      }

      if (foundItem != null) {
        detailClubState = DetailClubLoadSuccess(foundItem);
      } else {
        detailClubState = DetailClubError();
      }
    }, onFailed: (e, message) {
      _logger.e(e);
      AlertModel.showBasic("Erro", message);
    }, onDone: () {
      update();
    }));
  }

  Future<void> loadListHistoryEventClub() async {
    historyEventClubState = HistoryEventClubLoading();
    update();

    _repository.loadHistoryEventClub(
        response: ResponseHandler(onSuccess: (listHistoryEventClub) {
          historyEventClubState =
              HistoryEventClubLoadSuccess(listHistoryEventClub);
          listHistoryClub = listHistoryEventClub;
        }, onFailed: (e, message) {
          _logger.e(e);
          AlertModel.showBasic("Error", message);
          historyEventClubState = HistoryEventClubError();
        }, onDone: () {
          update();
        }),
        idTeam: id.value);
  }

  Future<void> toggleFavorite(String idTeam) async {
    bool isFavorite = await _favoriteHelper.isFavorite(idTeam);
    DetailClubModel? detailClub = (detailClubState is DetailClubLoadSuccess)
        ? (detailClubState as DetailClubLoadSuccess).detail
        : null;

    if (isFavorite) {
      await _favoriteHelper.removeFavorite(idTeam);
      FirebaseNotificationUtil().unsubscribeTopic(idTeam);
    } else {
      if (detailClub != null) {
        await _favoriteHelper.addFavorite(detailClub);
        FirebaseNotificationUtil().subscribeTopic(idTeam);
      }
    }
    update();
    Get.find<FavoriteController>().loadAllClubFavorite();
  }

  void firebaseController() {
    // Handle when onBackground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          'Pesan diterima saat di foreground halaman detail: ${message.notification?.title}');
      if (message.notification != null) {
        print('Notifikasi: ${message.notification?.title}');
        id.value = message.data['id'];
        loadDetailClub(id.value);
      }
    });
  }
}
