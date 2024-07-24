

// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';

import '../data/models/current_weather_data.dart';
import '../service/weather_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  String? city;
  HomeController({
    this.city,
  });
  CurrentWeatherData? currentWeatherData=CurrentWeatherData();
  List <CurrentWeatherData>?dataList=[];
  @override
  void onInit(){
    initState();
    getTopFiveCites();
    super.onInit();
  }
  void updateWeather(){
     initState();
  }
  void initState(){
    getCurrentWeatherData();
  }
  void getCurrentWeatherData(){
    WeatherService(city:city ).getCurrentWeatherData(
      onSuccess: (data){
        currentWeatherData=data;
        update();
      },
      onError: (error){
        log(error);
        update();
      }
    );
  }
  getTopFiveCites(){
    List<String>cites=[
      'cairo',
      'giza',
      'ismailia'
    ];
    cites.forEach((element) {
      WeatherService(city: city).getCurrentWeatherData(
        onSuccess: (data){
          dataList?.add(data);
          update();
        }
        ,
        onError: (error) {
          log(error);
          update();
        },
      );
     });
  }
}