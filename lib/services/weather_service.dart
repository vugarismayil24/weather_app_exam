import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/weather_model.dart';

class WeatherService {
  final Dio _dio = Dio();
  final String apiKey = '6f113c0b8ac8d863206b6cf6cb7c3e8b';

  Future<Weather> getWeather(double lat, double lon) async {
    try {
      final response = await _dio.get(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': apiKey,
          'units': 'metric',
        },
      );

      // Status code 200 kontrolü
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Weather data: ${response.data}');
        }
        return Weather.fromJson(response.data);
      } else {
        if (kDebugMode) {
          print('Failed to fetch weather data. Status code: ${response.statusCode}');
        }
        return Future.error('Failed to fetch weather data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching weather data: $e');
      }
      return Future.error('Error fetching weather data');
    }
  }
}






// https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey