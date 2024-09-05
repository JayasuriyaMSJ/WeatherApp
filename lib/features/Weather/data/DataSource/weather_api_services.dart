import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:intern_weather/core/APIs/api_keys.dart';
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/data/models/aqi_model.dart';

abstract class WeatherApiServices {
  double latitude;
  double longitude;
  String APIKey = ApiKeys.weatherAPIKey;
  WeatherApiServices({required this.latitude, required this.longitude});
  Future<Either<ErrorLog, void>> AQIService();
}

class WeatherApiServiceImpl extends WeatherApiServices {
  WeatherApiServiceImpl({
    required super.latitude,
    required super.longitude,
  });

  @override
  Future<Either<ErrorLog, String>> AQIService() async {
    try {
      final responce = await http.get(Uri.parse(
          "http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=${super.APIKey}"));
      final resBody = responce.body;
      if (responce.statusCode == 200){
        return Right("A");
      }
    } catch (e) {

    }
  }
}
