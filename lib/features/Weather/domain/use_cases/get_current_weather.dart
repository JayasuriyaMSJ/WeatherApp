import 'package:fpdart/fpdart.dart';
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/domain/Entities/current_weather_entity.dart';
import 'package:intern_weather/features/Weather/domain/Repository/weather_repository.dart';

class GetCurrentWeather {
  final WeatherRepository repository;
  GetCurrentWeather(
    this.repository,
  );
  Future<Either<ErrorLog, CurrentWeatherEntity>> executeCurrentWeather(double latitude, double longitude) async {
    return repository.getCurrentWeatherData(latitude, longitude);
  }
}
