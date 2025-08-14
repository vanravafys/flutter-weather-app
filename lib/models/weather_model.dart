class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final double humidity; // Pastikan properti ini ada
  final double windSpeed;
  final double pressure;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'] ?? 'Unknown City',
      temperature: (json['main']['temp'] as num?)?.toDouble() ?? 0.0,
      description: json['weather'][0]['description'] ?? 'No description',
      humidity:
          (json['main']['humidity'] as num?)?.toDouble() ??
          0.0, // Pastikan parsing-nya benar
      windSpeed: (json['wind']['speed'] as num?)?.toDouble() ?? 0.0,
      pressure: (json['main']['pressure'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
