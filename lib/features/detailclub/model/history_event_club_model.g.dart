// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_event_club_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryEventClubModel _$HistoryEventClubModelFromJson(
        Map<String, dynamic> json) =>
    HistoryEventClubModel(
      idEvent: json['idEvent'] as String?,
      strLeague: json['strLeague'] as String?,
      strHomeTeam: json['strHomeTeam'] as String?,
      strAwayTeam: json['strAwayTeam'] as String?,
      intHomeScore: json['intHomeScore'] as String?,
      intAwayScore: json['intAwayScore'] as String?,
      strHomeTeamBadge: json['strHomeTeamBadge'] as String?,
      strAwayTeamBadge: json['strAwayTeamBadge'] as String?,
      dateEvent: json['dateEvent'] as String?,
    );

Map<String, dynamic> _$HistoryEventClubModelToJson(
        HistoryEventClubModel instance) =>
    <String, dynamic>{
      'idEvent': instance.idEvent,
      'strLeague': instance.strLeague,
      'strHomeTeam': instance.strHomeTeam,
      'strAwayTeam': instance.strAwayTeam,
      'intHomeScore': instance.intHomeScore,
      'intAwayScore': instance.intAwayScore,
      'strHomeTeamBadge': instance.strHomeTeamBadge,
      'strAwayTeamBadge': instance.strAwayTeamBadge,
      'dateEvent': instance.dateEvent,
    };
