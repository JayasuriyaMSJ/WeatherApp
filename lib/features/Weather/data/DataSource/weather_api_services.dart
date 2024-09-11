import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/data/models/aqi_model.dart';
import 'package:intern_weather/features/Weather/data/models/current_weather_model.dart';

abstract class WeatherApiServices {
  final String apiKey;
  WeatherApiServices({required this.apiKey});
  Future<Either<ErrorLog, AqiModel>> aqiService(
      double latitude, double longitude);
  Future<Either<ErrorLog, CurrentWeatherModel>> currentWeatherService(
      double latitude, double longitude);
}

class WeatherApiServiceImpl extends WeatherApiServices {
  WeatherApiServiceImpl({
    required super.apiKey,
  });

  @override
  Future<Either<ErrorLog, AqiModel>> aqiService(
      double latitude, double longitude) async {
    try {
      final responce = await http.get(
        Uri.parse(
            "http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=${super.apiKey}"),
      );
      final resBody = responce.body;
      final res = jsonDecode(resBody);

      if (responce.statusCode == 200) {
        final aqiRes = res['list'][0];
        // directly Deployed in AQIModel
        // {
        // final airQuality = aqiRes['main']['aqi'];
        // final airComponents = aqiRes['component'];
        // final time = aqiRes['dt'];
        // }
        return Right(
          AqiModel.fromMap(aqiRes),
        );
      } else {
        return Left(
          ErrorLog(
            "Error:  $resBody",
          ),
        );
      }
    } catch (e) {
      return Left(ErrorLog(e.toString()));
    }
  }

  @override
  Future<Either<ErrorLog, CurrentWeatherModel>> currentWeatherService(
      double latitude, double longitude) async {
    try {
      final responce = await http.get(
        Uri.parse(
            "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=${super.apiKey}"),
      );
      final resBody = responce.body;

      if (responce.statusCode == 200) {
        final res = jsonDecode(resBody);
        print("Result from currentWeatherServide:\n $res");
        return Right(
          CurrentWeatherModel.fromMap(res),
        );
      } else {
        return Left(
          ErrorLog(
            "Error:  $resBody",
          ),
        );
      }
    } catch (e) {
      return Left(ErrorLog(e.toString()));
    }
  }
}
