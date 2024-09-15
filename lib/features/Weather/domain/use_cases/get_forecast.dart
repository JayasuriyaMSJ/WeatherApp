import 'package:fpdart/fpdart.dart';
import 'package:intern_weather/core/logs/errors/error_logs.dart';
import 'package:intern_weather/features/Weather/domain/Entities/forecast_entity.dart';
import 'package:intern_weather/features/Weather/domain/Repository/weather_repository.dart';

class GetForecast {
  final WeatherRepository weatherRepository;
  GetForecast(this.weatherRepository);

  Future<Either<ErrorLog, List<ForecastEntity>>> executeForecast(double latitude, double longitude) async {
    return weatherRepository.getForecastData(latitude, longitude);
  }
}
