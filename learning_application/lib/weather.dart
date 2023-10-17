// import 'package:weather/weather.dart';
//
// double lat = 55.0111;
// double lon = 15.0569;
// String key = 'c300c80ed84337d8935f3ac171a7112a';
// String cityName = 'Kongens Lyngby';
// WeatherFactory wf = WeatherFactory(key);
//
//
// Weather w = await wf.currentWeatherByCityName(cityName);

import 'package:weather/weather.dart';

Future<void> fetchWeatherData(String city) async {
  final apiKey = 'c300c80ed84337d8935f3ac171a7112a'; // Replace with your actual API key
  final weatherFactory = WeatherFactory(apiKey);

  try {
    print('AAAAAAAAAAAAAAAAAAAA');
    Weather weather = await weatherFactory.currentWeatherByCityName(city);
    print('Temperature in $city: ${weather.temperature?.celsius}°C');
    print('Weather in $city: ${weather.weatherMain}');
  } catch (e) {
    print('Error fetching weather data: $e');
  }
}


