class DetailClubModel {
  String? idTeam;
  String? nameTeam;
  String? badge;
  String? formedYear;
  String? description;
  String? facebookUrl;
  String? instagramUrl;
  String? twitterUrl;
  String? staidion;

  DetailClubModel({
    this.idTeam,
    this.nameTeam,
    this.badge,
    this.formedYear,
    this.description,
    this.facebookUrl,
    this.instagramUrl,
    this.twitterUrl

  });

  DetailClubModel.fromJson(Map<String, dynamic> json){
    idTeam = json["idTeam"];
    nameTeam = json["strTeam"];
    badge = json["strBadge"];
    formedYear = json["intFormedYear"];
    description =json["strDescriptionEN"];
    facebookUrl = json["strFacebook"];
    instagramUrl = json["strInstagram"];
    twitterUrl = json["strTwitter"];
    staidion = json["strStadium"];
  }

  Map<String, dynamic>toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idTeam']=idTeam;
    data['strTeam']=nameTeam;
    data['strBadge']=badge;
    data['intFormedYear']=formedYear;
    data['strDescriptionEN']=description;
    data['strFacebook']= facebookUrl;
    data['strInstagram']= instagramUrl;
    data['strTwitter']= twitterUrl;
    data["strStadium"] = staidion;
    return data;
  }

}