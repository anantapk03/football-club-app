import 'package:get/get.dart';

import '../../../../components/util/state.dart';
import '../../repository/detailclub_repository.dart';
import 'equipment_state.dart';

class EquipmentController extends GetxController {
  final DetailclubRepository _repository;
  EquipmentState equipmentState = EquipmentIdle();
  EquipmentController(this._repository);

  final id = "".obs;

  Future<void> loadHistoryEquipment() async {
    try {
      equipmentState = EquipmentLoading();
      update();
      await _repository.loadHistoryEquipment(
        response: ResponseHandler(
          onSuccess: (listEquipment) async {
            equipmentState = EquipmentLoadSuccess(listEquipment);
          },
          onFailed: (e, message) {
            equipmentState = EquipmentError();
          },
          onDone: () {
            update();
          },
        ),
        idTeam: id.value,
      );
    } catch (e) {
      equipmentState = EquipmentError();
      update();
    }
  }
}
