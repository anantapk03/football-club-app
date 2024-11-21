import 'package:json_annotation/json_annotation.dart';

part 'equipment_item_model.g.dart';

@JsonSerializable()
class EquipmentItemModel {
  final String? idEquipment;
  final String? idTeam;
  final String? date;
  final String? strSeason;
  final String? strEquipment;
  final String? strType;
  final String? strUsername;

  EquipmentItemModel({
    required this.idEquipment,
    required this.idTeam,
    required this.date,
    required this.strSeason,
    required this.strEquipment,
    required this.strType,
    required this.strUsername,
  });

  factory EquipmentItemModel.fromJson(Map<String, dynamic> json) =>
      _$EquipmentItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$EquipmentItemModelToJson(this);
}
