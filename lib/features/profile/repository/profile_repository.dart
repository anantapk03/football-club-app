import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../components/util/storage_util.dart';

class ProfileRepository {
  final StorageUtil _storageUtil;
  final _logger = Logger();
  final isLang = 1.obs;

  ProfileRepository(this._storageUtil);

  Future<String?> getLanguage() async {
    String? lang = await _storageUtil.getLanguage();
    _logger.i("Get Language Now : ${lang.toString()}");
    return lang;
  }
}
