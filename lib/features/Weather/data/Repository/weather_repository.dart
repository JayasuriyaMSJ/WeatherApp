import 'package:intern_weather/features/Weather/data/DataSource/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherAPI;
  WeatherRepository({required this.weatherAPI});

  Future<void> getAQI(double latitude, double longitude) async {
    final aqiData = await weatherAPI.aqiService(latitude, longitude);
    print(aqiData);
  }
}