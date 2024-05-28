import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../services/location_service.dart';

class WeatherNotifier extends StateNotifier<AsyncValue<Weather>> {
  WeatherNotifier() : super(const AsyncValue.loading()) {
    fetchWeatherForDefaultLocation();
  }

  final WeatherService _weatherService = WeatherService();
  final LocationService _locationService = LocationService();

  Future<void> fetchWeatherForDefaultLocation() async {
    try {
      final position = await _locationService.getCurrentLocation();
      final weather = await _weatherService.getWeather(position.latitude, position.longitude);
      state = AsyncValue.data(weather);
    } catch (e) {
      // Default Location Baku
      final weather = await _weatherService.getWeather(40.4093, 49.8671);
      state = AsyncValue.data(weather);
    }
  }

  Future<void> fetchWeatherForCity(double lat, double lon) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _weatherService.getWeather(lat, lon);
      state = AsyncValue.data(weather);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e.toString(), stackTrace);
    }
  }

  Future<void> fetchWeatherForCurrentLocation() async {
    try {
      state = const AsyncValue.loading();
      final position = await _locationService.getCurrentLocation();
      final weather = await _weatherService.getWeather(position.latitude, position.longitude);
      state = AsyncValue.data(weather);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e.toString(), stackTrace);
    }
  }
}

final weatherProvider = StateNotifierProvider<WeatherNotifier, AsyncValue<Weather>>((ref) {
  return WeatherNotifier();
});
