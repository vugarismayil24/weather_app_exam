import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_notifier.dart';
import '../widgets/city_button_widget.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherState = ref.watch(weatherProvider);
    final weatherNotifier = ref.read(weatherProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Weather App')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                CityButton(cityName: "Your Location", onPressed: () => weatherNotifier.fetchWeatherForCurrentLocation()),
                CityButton(cityName: "New York", onPressed: () => weatherNotifier.fetchWeatherForCity(40.7128, -74.0060)),
                CityButton(cityName: "London", onPressed: () => weatherNotifier.fetchWeatherForCity(51.5074, -0.1278)),
                CityButton(cityName: "Tokyo", onPressed: () => weatherNotifier.fetchWeatherForCity(35.6895, 139.6917)),
                CityButton(cityName: "Sydney", onPressed: () => weatherNotifier.fetchWeatherForCity(-33.8688, 151.2093)),
                CityButton(cityName: "Paris", onPressed: () => weatherNotifier.fetchWeatherForCity(48.8566, 2.3522)),
                CityButton(cityName: "Moscow", onPressed: () => weatherNotifier.fetchWeatherForCity(55.7558, 37.6173)),
                CityButton(cityName: "Beijing", onPressed: () => weatherNotifier.fetchWeatherForCity(39.9042, 116.4074)),
                CityButton(cityName: "Rio de Janeiro", onPressed: () => weatherNotifier.fetchWeatherForCity(-22.9068, -43.1729)),
                CityButton(cityName: "Cape Town", onPressed: () => weatherNotifier.fetchWeatherForCity(-33.9249, 18.4241)),
              ],
            ),
          ),
          Expanded(
            child: weatherState.when(
              data: (weather) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network('https://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                    Text(weather.cityName, style: const TextStyle(fontSize: 30)),
                    Text('${weather.temperature}°C', style: const TextStyle(fontSize: 50)),
                    Text(weather.description, style: const TextStyle(fontSize: 20)),
                    Text('Local Time: ${weather.localTime}', style: const TextStyle(fontSize: 20)),
                    
                  ],
                ),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}


