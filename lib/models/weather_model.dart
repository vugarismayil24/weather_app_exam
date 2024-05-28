class Weather {
  final double temperature;
  final String description;
  final String cityName;
  final String localTime;
  final String? icon; 
  
  Weather({
    required this.temperature,
    required this.description,
    required this.cityName,
    required this.localTime,
    required this.icon,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temperature: json['main']['temp'],
      description: json['weather'][0]['description'],
      cityName: json['name'] ?? 'Unknown Location',
      localTime: _parseLocalTime(json['timezone']),
      icon: json['weather'][0]['icon'], 
    );
  }

  // Method that calculates time information
  static String _parseLocalTime(int timezoneOffset) {
    final currentTime = DateTime.now().toUtc().add(Duration(seconds: timezoneOffset));
    return '${currentTime.hour.toString().padLeft(2, '0')}:${currentTime.minute.toString().padLeft(2, '0')}';
  }
}


