import '../../model/list_equipment_model.dart';

abstract class EquipmentState {}

class EquipmentLoadSuccess extends EquipmentState {
  final ListEquipmentModel? listEquipment;

  EquipmentLoadSuccess(this.listEquipment);
}

class EquipmentLoading extends EquipmentState {}

class EquipmentIdle extends EquipmentState {}

class EquipmentError extends EquipmentState {}
