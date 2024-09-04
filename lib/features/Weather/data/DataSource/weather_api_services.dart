import 'package:intern_weather/core/APIs/api_keys.dart';

abstract class WeatherApiServices {
  double latitude;
  double longitude;
  String APIKey = ApiKeys.weatherAPIKey;
  WeatherApiServices({required this.latitude, required this.longitude});
  String AQIService();
}

class WeatherApiServiceImpl extends WeatherApiServices {
  
  WeatherApiServiceImpl({
    required double latitude,
    required double longitude,
  }) : super(latitude: latitude, longitude: longitude){}

  @override
  String AQIService() {
    // TODO: implement AQIService
    throw UnimplementedError();
  }
}
