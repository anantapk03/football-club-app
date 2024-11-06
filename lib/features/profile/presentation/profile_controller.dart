import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../components/services/database/app_database.dart';
import '../../../components/util/storage_util.dart';
import '../../../main.dart';
import 'profile_state.dart';

class ProfileController extends GetxController {
  final StorageUtil storageUtil;
  final _logger = Logger();
  var profileState = Rx<ProfileState>(ProfileIdle());
  final isLang = 1.obs;
  final AppDatabase _appDatabase = Get.find<AppDatabase>();

  ProfileController(this.storageUtil);

  final totalFavorite = 0.obs;
  final listFavoriteClubSqlite = <ClubTableData>[].obs;
  RxList<ClubTableData> clubs = <ClubTableData>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getTotalFavorite();
    _logger.i(totalFavorite.value);
  }

  void setIsLang(int value) {
    isLang.value = value;
  }

  void saveLanguage(BuildContext context) {
    if (isLang.value == 1) {
      storageUtil.setLanguage("id-ID");
      MyApp.setLocal(context, const Locale("id"));
    } else {
      storageUtil.setLanguage("en-US");
      MyApp.setLocal(context, const Locale("en"));
    }
  }

  Future<void> getTotalFavorite() async {
    profileState.value = ProfileLoading();
    update();
    try {
      listFavoriteClubSqlite.value =
          await _appDatabase.select(_appDatabase.clubTable).get();
      totalFavorite.value = listFavoriteClubSqlite.length;
      await Future.delayed(const Duration(seconds: 1)).then((onValue) {
        profileState.value = ProfileSuccess(listFavoriteClubSqlite);
      });
      _logger.d("Total favorite updated: ${totalFavorite.value}");

      update();
    } catch (e) {
      _logger.e("Failed to load total favorites: $e");
      profileState.value = ProfileError();
    } finally {
      update();
    }
  }
}
