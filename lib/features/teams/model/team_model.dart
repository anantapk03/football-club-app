class TeamModel{
  String? idTeam;
  String? nameTeam;
  String? badge;

  TeamModel({this.idTeam, this.nameTeam, this.badge});

  TeamModel.fromJson(Map<String, dynamic> json){
    idTeam = json["idTeam"];
    nameTeam = json["strTeam"];
    badge = json["strBadge"];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTeam'] = idTeam;
    data['strTeam'] = nameTeam;
    data['strBadge'] = badge;
    return data;
  }
}