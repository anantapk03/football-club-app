import 'package:json_annotation/json_annotation.dart';

part 'league_item_model.g.dart';

@JsonSerializable()
class LeagueItemModel {
  String? idLeague;
  String? strLeague;
  String? strBadge;
  String? strLogo;
  String? strDescriptionEN;

  LeagueItemModel({
    this.strLeague,
    this.idLeague,
    this.strBadge,
    this.strDescriptionEN,
    this.strLogo,
  });

  factory LeagueItemModel.fromJson(Map<String, dynamic> json) =>
      _$LeagueItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeagueItemModelToJson(this);
}
