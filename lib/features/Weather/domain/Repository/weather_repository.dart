import 'package:fpdart/fpdart.dart';
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/domain/Entities/aqi_entity.dart';

abstract interface class WeatherRepository {
  Future<Either<ErrorLog, AqiEntity>> getAQI(
    double latitude,
    double longitude,
  );
}
