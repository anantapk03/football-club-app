import 'package:json_annotation/json_annotation.dart';

part 'history_event_club_model.g.dart';

@JsonSerializable()
class HistoryEventClubModel {
  String? idEvent;
  String? strLeague;
  String? strHomeTeam;
  String? strAwayTeam;
  String? intHomeScore;
  String? intAwayScore;
  String? strHomeTeamBadge;
  String? strAwayTeamBadge;
  String? dateEvent;

  HistoryEventClubModel({
    this.idEvent,
    this.strLeague,
    this.strHomeTeam,
    this.strAwayTeam,
    this.intHomeScore,
    this.intAwayScore,
    this.strHomeTeamBadge,
    this.strAwayTeamBadge,
    this.dateEvent,
  });
  factory HistoryEventClubModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryEventClubModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryEventClubModelToJson(this);
}
