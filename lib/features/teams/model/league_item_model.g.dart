// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueItemModel _$LeagueItemModelFromJson(Map<String, dynamic> json) =>
    LeagueItemModel(
      strLeague: json['strLeague'] as String?,
      idLeague: json['idLeague'] as String?,
      strBadge: json['strBadge'] as String?,
      strDescriptionEN: json['strDescriptionEN'] as String?,
      strLogo: json['strLogo'] as String?,
    );

Map<String, dynamic> _$LeagueItemModelToJson(LeagueItemModel instance) =>
    <String, dynamic>{
      'idLeague': instance.idLeague,
      'strLeague': instance.strLeague,
      'strBadge': instance.strBadge,
      'strLogo': instance.strLogo,
      'strDescriptionEN': instance.strDescriptionEN,
    };
