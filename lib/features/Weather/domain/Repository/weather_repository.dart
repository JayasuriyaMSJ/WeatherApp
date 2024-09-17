import 'package:fpdart/fpdart.dart';
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/domain/Entities/aqi_entity.dart';
import 'package:intern_weather/features/Weather/domain/Entities/current_weather_entity.dart';
import 'package:intern_weather/features/Weather/domain/Entities/forecast_entity.dart';

abstract interface class WeatherRepository {
  Future<Either<ErrorLog, AqiEntity>> getAQI(
    double latitude,
    double longitude,
  );
  Future<Either<ErrorLog, CurrentWeatherEntity>> getCurrentWeatherData(
    double latitude,
    double longitude,
  );
  Future<Either<ErrorLog, List<ForecastEntity>>> getForecastData(
    double latitude,
    double longitude,
  );
}
