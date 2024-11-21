import 'package:json_annotation/json_annotation.dart';

import 'equipment_item_model.dart';

part 'list_equipment_model.g.dart';

@JsonSerializable()
class ListEquipmentModel {
  final List<EquipmentItemModel>? equipment;

  ListEquipmentModel({this.equipment});

  factory ListEquipmentModel.fromJson(Map<String, dynamic> json) =>
      _$ListEquipmentModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListEquipmentModelToJson(this);
}
