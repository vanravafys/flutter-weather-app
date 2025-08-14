import 'package:flutter/material.dart';

class WeatherIcons {
  static IconData getIcon(String condition) {
    condition = condition.toLowerCase();

    if (condition.contains('thunderstorm')) {
      return Icons.flash_on;
    } else if (condition.contains('rain') || condition.contains('drizzle')) {
      return Icons.umbrella;
    } else if (condition.contains('snow')) {
      return Icons.ac_unit;
    } else if (condition.contains('cloud')) {
      return Icons.cloud;
    } else if (condition.contains('sun') || condition.contains('clear')) {
      return Icons.wb_sunny;
    } else if (condition.contains('fog') || condition.contains('mist')) {
      return Icons.cloud_queue;
    } else {
      return Icons.wb_cloudy;
    }
  }

  static Color getIconColor(String condition) {
    condition = condition.toLowerCase();
    if (condition.contains('sun') || condition.contains('clear')) {
      return const Color(0xFFF5A623); // Oranye
    }
    return const Color(0xFF4A80F0); // Biru
  }
}
