// ignore_for_file: public_member_api_docs, sort_constructors_first
class Wind {
  double? speed;
  double?deg;
  Wind({
    this.speed,
    this.deg,
  });
  
  
  Map<String, dynamic> toJson() {
    return {
      'speed': speed,
      'deg': deg,
    };
  }

  factory Wind.fromJson(Map<String, dynamic> json) {
    return Wind(
      speed:double.parse(json["speed"]),
      deg:double.parse(json["deg"]),
    );
  }
}
