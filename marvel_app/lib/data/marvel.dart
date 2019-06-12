import 'dart:convert'; //to use json's encode and decode

Marvel marvelFromJson(String str) => Marvel.fromJson(json.decode(str));

String marvelToJson(Marvel data) => json.encode(data.toJson());

class Marvel {
  String name;
  String realName;
  String team;
  String firstAppearance;
  String createdBy;
  String publisher;
  String imageUrl;
  String bio;

  Marvel({
    this.name,
    this.realName,
    this.team,
    this.firstAppearance,
    this.createdBy,
    this.publisher,
    this.imageUrl,
    this.bio,
  });

  factory Marvel.fromJson(Map<String, dynamic> json) => Marvel(
        name: json["name"],
        realName: json["realname"],
        team: json["team"],
        firstAppearance: json["firstappearance"],
        createdBy: json["createdby"],
        publisher: json["publisher"],
        imageUrl: json["imageurl"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "realname": realName,
        "team": team,
        "firstappearance": firstAppearance,
        "createdby": createdBy,
        "publisher": publisher,
        "imageurl": imageUrl,
        "bio": bio,
      };

  @override
  String toString() {
    return "Name: $name \tReal Name: $realName \nTeam: $team \nFirst Appearance: $firstAppearance\nCreated By: $createdBy";
  }
}
