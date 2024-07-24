class Sys{
  int?id;
  String?country;
  int?sunrise;
  int?sunset;

  Sys({
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country':country,
      'sunrise':sunrise,
      'sunset':sunset
    };
  }

  factory Sys.fromJson(Map<String, dynamic> json) {
    return Sys(
      id:int.parse(json["id"]),
      country:json["country"],
      sunrise:int.parse(json["sunrise"]),
      sunset:int.parse(json["sunset"]),
    );
  }

}