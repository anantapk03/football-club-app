// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipment_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquipmentItemModel _$EquipmentItemModelFromJson(Map<String, dynamic> json) =>
    EquipmentItemModel(
      idEquipment: json['idEquipment'] as String?,
      idTeam: json['idTeam'] as String?,
      date: json['date'] as String?,
      strSeason: json['strSeason'] as String?,
      strEquipment: json['strEquipment'] as String?,
      strType: json['strType'] as String?,
      strUsername: json['strUsername'] as String?,
    );

Map<String, dynamic> _$EquipmentItemModelToJson(EquipmentItemModel instance) =>
    <String, dynamic>{
      'idEquipment': instance.idEquipment,
      'idTeam': instance.idTeam,
      'date': instance.date,
      'strSeason': instance.strSeason,
      'strEquipment': instance.strEquipment,
      'strType': instance.strType,
      'strUsername': instance.strUsername,
    };
