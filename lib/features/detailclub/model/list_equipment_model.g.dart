// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_equipment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListEquipmentModel _$ListEquipmentModelFromJson(Map<String, dynamic> json) =>
    ListEquipmentModel(
      equipment: (json['equipment'] as List<dynamic>?)
          ?.map((e) => EquipmentItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListEquipmentModelToJson(ListEquipmentModel instance) =>
    <String, dynamic>{
      'equipment': instance.equipment,
    };
