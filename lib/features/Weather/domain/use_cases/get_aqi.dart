import 'package:fpdart/fpdart.dart';
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/domain/Entities/aqi_entity.dart';
import 'package:intern_weather/features/Weather/domain/Repository/weather_repository.dart';

class GetAqi {
  final WeatherRepository repository;
  GetAqi(this.repository);
  Future<Either<ErrorLog, AqiEntity>> executeAQI(
    double latitude,
    double longitude,
  ) async {
    return await repository.getAQI(latitude, longitude);
  }
}
