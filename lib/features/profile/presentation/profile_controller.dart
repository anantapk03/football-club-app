import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../components/util/storage_util.dart';
import '../../../main.dart';

class ProfileController extends GetxController {
  final StorageUtil storageUtil;
  final _logger = Logger();
  final isLang = 1.obs;

  ProfileController(this.storageUtil);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
}
