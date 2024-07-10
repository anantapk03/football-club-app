import 'package:get/get_state_manager/get_state_manager.dart';

import '../util/storage_util.dart';

class AppService extends GetxService {
  // ignore: unused_field
  final StorageUtil _storage;

  AppService(this._storage);
}