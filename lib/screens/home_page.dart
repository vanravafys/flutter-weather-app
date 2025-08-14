import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _searchController = TextEditingController();
  WeatherModel? _weather;
  bool _isLoading = true;
  String _errorMessage = '';
  String _currentLocation = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocationWeather();
  }

  Future<void> _fetchCurrentLocationWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weatherData = await _weatherService.getCurrentWeather();
      setState(() {
        _weather = WeatherModel.fromJson(weatherData);
        _currentLocation = _weather!.city;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat data cuaca: $e';
      });
    }
  }

  Future<void> _searchWeather(String city) async {
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final weatherData = await _weatherService.getWeatherByCity(city);
      setState(() {
        _weather = WeatherModel.fromJson(weatherData);
        _currentLocation = _weather!.city;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Gagal memuat data cuaca untuk $city: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryBackgroundColor,
      appBar: AppBar(
        title: Text(
          _currentLocation,
          style: TextStyle(color: AppTheme.primaryTextColor, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: AppTheme.primaryTextColor),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Cari Kota'),
                  content: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Masukkan nama kota',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Batal'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _searchWeather(_searchController.text);
                        Navigator.pop(context);
                      },
                      child: const Text('Cari'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.accentColor),
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return _buildErrorView();
    }

    if (_weather == null) {
      return _buildNoWeatherView();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildMainWeatherCard(),
          const SizedBox(height: 24),
          _buildWeatherDetailsGrid(),
        ],
      ),
    );
  }

  Widget _buildMainWeatherCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.weatherCardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _currentLocation,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${_weather!.temperature}°C',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getWeatherIcon(_weather!.description),
              const SizedBox(width: 8),
              Text(
                _weather!.description,
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _buildDetailCard(
            'Kelembaban',
            '${_weather!.humidity}%',
            Icons.water_drop,
          ),
          _buildDetailCard('Angin', '${_weather!.windSpeed} km/j', Icons.air),
          _buildDetailCard('Tekanan', '${_weather!.pressure} hPa', Icons.speed),
          _buildDetailCard('UV Index', '3', Icons.wb_sunny),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: AppTheme.primaryColor),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 14)),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 50, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            _errorMessage,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _fetchCurrentLocationWeather,
            icon: const Icon(Icons.refresh),
            label: const Text('Coba Lagi'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Geolocator.openAppSettings(),
            child: const Text('Buka Pengaturan Lokasi'),
          ),
        ],
      ),
    );
  }

  Widget _buildNoWeatherView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, size: 50, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'Data cuaca tidak tersedia',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _fetchCurrentLocationWeather,
            child: const Text('Muat Ulang'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getWeatherIcon(String description) {
    if (description.toLowerCase().contains('rain')) {
      return const Icon(Icons.umbrella, color: Colors.white, size: 28);
    } else if (description.toLowerCase().contains('cloud')) {
      return const Icon(Icons.cloud, color: Colors.white, size: 28);
    } else {
      return const Icon(Icons.wb_sunny, color: Colors.white, size: 28);
    }
  }
}
