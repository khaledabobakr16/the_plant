class MainWeather{
  double?temp;
  double?feelsLike;
  double? tempMin;
  double? tempMax;
  double?pressure;
  double?humidity;
  MainWeather({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });
  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'feelsLike': feelsLike,
      'tempMin':tempMin,
      'tempMax':tempMax,
      'pressure':pressure,
      'humidity':humidity
    };
  }

  factory MainWeather.fromJson(Map<String, dynamic> json) {
    return MainWeather(
      temp:double.parse(json["temp"]),
      feelsLike:double.parse(json["feelsLike"]),
      tempMin:double.parse(json["tempMin"]),
      tempMax:double.parse(json["tempMax"]),
      pressure:double.parse(json["pressure"]),
      humidity:double.parse(json["humidity"]),
    );
  }
  
}