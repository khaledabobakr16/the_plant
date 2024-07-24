import '../models/clouds.dart';
import '../models/coord.dart';
import '../models/main_weather.dart';
import '../models/sys.dart';
import '../models/weather.dart';
import '../models/wind.dart';

class CurrentWeatherData{
  Coord? coord;
  List<Weather>?weather;
  String?base;
  MainWeather?main;
  Wind?wind;
  int? visibility;
  Clouds?clouds;
  int? dt;
  Sys?sys;
  int?timezone;
  int?id;
  String?name;
  int?cod;

  CurrentWeatherData({
  this.coord,
  this.weather,
  this.wind,
  this.base,
  this.main,
  this.visibility,
  this.clouds,
  this.dt,
  this.sys,
  this.timezone,
  this.id,
  this.name,
  this.cod,
  });
    
  // Map<String, dynamic> toJson() {
  //   return {
  //     'coord': coord,
  //     'weather': weather,
  //     'base': base,
  //     'mainWeather': mainWeather,
  //     'visibility': visibility,
  //     'clouds': clouds,
  //     'dt': dt,
  //     'sys': sys,
  //     'timezone': timezone,
  //     'id': id,
  //     'name': name,
  //     'cod': cod,
  //   };
  // }

  factory CurrentWeatherData.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherData(
      coord:Coord.fromJson(json["coord"]),
      weather: List.of(json["weather"]),
      base: json["base"],
      main: MainWeather.fromJson(json["mainWeather"]),
      visibility:int.parse(json["visibility"]),
      clouds: Clouds.fromJson(json["clouds"]),
      dt:int.parse(json["dt"]),
      sys:Sys.fromJson(json["sys"]),
      timezone: int.parse(json["timezone"]),
      id:int.parse(json["id"]),
      name:json["name"],
      cod:int.parse(json["cod"])
    );
  }
}