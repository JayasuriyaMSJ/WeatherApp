import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/data/models/aqi_model.dart';
import 'package:intern_weather/features/Weather/data/models/current_weather_model.dart';
import 'package:intern_weather/features/Weather/data/models/forecast_model.dart';

abstract class WeatherApiServices {
  final String apiKey;

  WeatherApiServices({required this.apiKey});

  Future<Either<ErrorLog, AqiModel>> aqiService(double latitude, double longitude);
  Future<Either<ErrorLog, CurrentWeatherModel>> currentWeatherService(double latitude, double longitude);
  Future<Either<ErrorLog, List<ForecastModel>>> weatherForecast(double latitude, double longitude);
}

class WeatherApiServiceImpl extends WeatherApiServices {
  WeatherApiServiceImpl({required super.apiKey});

  // Common HTTP request handler
  Future<Either<ErrorLog, Map<String, dynamic>>> _get(String url) async {
    try {
      print("Making HTTP GET request to: $url");
      final response = await http.get(Uri.parse(url));
      print("HTTP GET Response status code: ${response.statusCode}");
      
      final resBody = response.body;
      print("HTTP GET Response body: $resBody");

      if (response.statusCode == 200) {
        return Right(jsonDecode(resBody));
      } else {
        return Left(ErrorLog("Error: $resBody"));
      }
    } catch (e) {
      print("Exception during HTTP request: ${e.toString()}");
      return Left(ErrorLog(e.toString()));
    }
  }

  @override
  Future<Either<ErrorLog, AqiModel>> aqiService(double latitude, double longitude) async {
    final url = "http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey";
    
    print("Fetching AQI data...");
    final result = await _get(url);
    
    return result.fold(
      (error) {
        print("Error fetching AQI data: ${error.message}");
        return Left(error);
      },
      (data) {
        try {
          print("AQI raw data: $data");
          final aqiRes = data['list'][0];
          print("AQI result: $aqiRes");
          return Right(AqiModel.fromMap(aqiRes));
        } catch (e) {
          print("Error parsing AQI data: ${e.toString()}");
          return Left(ErrorLog("Failed to parse AQI data: ${e.toString()}"));
        }
      },
    );
  }

  @override
  Future<Either<ErrorLog, CurrentWeatherModel>> currentWeatherService(double latitude, double longitude) async {
    final url = "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey";
    
    print("Fetching current weather data...");
    final result = await _get(url);

    return result.fold(
      (error) {
        print("Error fetching current weather data: ${error.message}");
        return Left(error);
      },
      (data) {
        try {
          print("Current weather raw data: $data");
          return Right(CurrentWeatherModel.fromMap(data));
        } catch (e) {
          print("Error parsing current weather data: ${e.toString()}");
          return Left(ErrorLog("Failed to parse current weather data: ${e.toString()}"));
        }
      },
    );
  }

  @override
  Future<Either<ErrorLog, List<ForecastModel>>> weatherForecast(double latitude, double longitude) async {
    final url = "http://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$apiKey";

    print("Fetching weather forecast data...");
    final result = await _get(url);

    return result.fold(
      (error) {
        print("Error fetching forecast data: ${error.message}");
        return Left(error);
      },
      (data) {
        try {
          print("Forecast raw data: $data");
          final List forecastList = data['list'];
          print("Parsed forecast list: $forecastList");
          
          final forecastModels = forecastList.map((json) => ForecastModel.fromMap(json)).toList();
          print("Mapped ForecastModel list: $forecastModels");
          
          return Right(forecastModels);
        } catch (e) {
          print("Error parsing forecast data: ${e.toString()}");
          return Left(ErrorLog("Failed to parse Forecast data: ${e.toString()}"));
        }
      },
    );
  }
}
