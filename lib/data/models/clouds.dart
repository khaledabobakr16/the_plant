class Clouds{
  int?all;
  Clouds({
    this.all,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'all': all,
    };
  }

  factory Clouds.fromJson(Map<String, dynamic> json) {
    return Clouds(
      all:int.parse(json["all"]),
    );
  }
}