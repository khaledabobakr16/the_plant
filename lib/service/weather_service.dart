import '../api/api_repo.dart';
import '../data/models/current_weather_data.dart';

class WeatherService{
  String? city;
  WeatherService({
    this.city
  });
  String baseUrl="https://api.openweathermap.org/data/2.5";
  String apiKey="appid=b55e8a8c485fab5454debfa45eb272c4";

  void getCurrentWeatherData(
    {
    Function()?beforeSend,
    Function(CurrentWeatherData currentWeatherData)?onSuccess,
    Function(dynamic error)?onError,
    }
  ){
    final url="$baseUrl/weather?q=$city&$apiKey";
    ApiRepo(url: url,payload: null).getData(
      beforeSend: () => beforeSend!(),
      onSuccess: (data)=>onSuccess!(CurrentWeatherData.fromJson(data)),
      onError: (error)=>onError!(error)
    );
  }
}